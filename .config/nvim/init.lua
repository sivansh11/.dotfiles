vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.nu = true
vim.o.rnu = true
vim.o.signcolumn = 'yes'
vim.o.undofile = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = 'unnamedplus'
vim.o.confirm = true
vim.o.wildmenu = true
vim.o.scrolloff = 10
vim.o.background = 'dark'
-- vim.o.cmdheight = 0

-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "", -- Nerd Font icon for error
      [vim.diagnostic.severity.WARN] = "", -- Nerd Font icon for warning
      [vim.diagnostic.severity.INFO] = "", -- Nerd Font icon for info
      [vim.diagnostic.severity.HINT] = "󱜹", -- Nerd Font icon for hint
    }
  },
  update_in_insert = false,
})

vim.pack.add({
  -- colorschemes
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },

  -- lsp dap (Mason to install lsp's)
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
  { src = 'https://github.com/igorlfs/nvim-dap-view', },

  -- treesitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

  { src = 'https://github.com/aserowy/tmux.nvim' },

  -- completions
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1.8.0'
  },

  { src = 'https://github.com/stevearc/oil.nvim' },

  { src = 'https://github.com/XXiaoA/atone.nvim' },

  { src = 'https://github.com/nvim-mini/mini.nvim' },

  { src = 'https://github.com/sindrets/diffview.nvim' },

  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  { src = 'https://github.com/julienvincent/hunk.nvim' },

  { src = 'https://github.com/sivansh11/jj' },

  { src = 'https://github.com/akinsho/toggleterm.nvim' },

  -- not needed
  { src = 'https://github.com/folke/lazydev.nvim' },
})

require('gruvbox').setup({
  transparent_mode = true,
  overrides = {
    SignColumn = { link = "Normal" }
  }
})

-- require('mini.basics').setup()
require('mini.files').setup()

local cache = {}

local function get_buf_realpath(buf_id)
  return vim.loop.fs_realpath(vim.api.nvim_buf_get_name(buf_id)) or ''
end

local function repo_dir(path)
  local result = vim.system({ 'jj', '--ignore-working-copy', 'root' }, { cwd = vim.fs.dirname(path) }):wait()
  if result.code == 0 then
    return vim.trim(result.stdout)
  else
    return nil
  end
end

local function invalidate_cache(buf_id)
  local cache = cache[buf_id]
  if cache == nil then return false end
  pcall(function()
    cache.fs_event:stop()
    cache.timer:stop()
  end)
  cache[buf_id] = nil
end

local function start_watching(buf_id, path)
  local repo = repo_dir(path)
  if repo == nil then return false end
  local watchfile = vim.fs.joinpath(repo, ".jj/working_copy")

  local buf_fs_event, timer = vim.loop.new_fs_event(), vim.loop.new_timer()
  local set_ref_text = function()
    vim.system(
      { "jj", "--ignore-working-copy", "file", "show", "-r", "@-", "\"" .. path .. "\"" },
      { cwd = vim.fs.dirname(path), text = true },
      vim.schedule_wrap(function(res)
        local MiniDiff = require('mini.diff')
        MiniDiff.set_ref_text(buf_id, res.stdout)
      end)
    )
  end

  local watch_index = function(_, filename, _)
    if filename ~= "checkout" then return end
    timer:stop()
    timer:start(50, 0, set_ref_text)
  end
  buf_fs_event:start(watchfile, { recursive = true }, watch_index)

  invalidate_cache(buf_id)
  cache[buf_id] = { fs_event = buf_fs_event, timer = timer }

  set_ref_text()
end

require('mini.diff').setup({
  view = {
    style = "sign"
  },
  source = {
    name = "jj",
    attach = function(buf_id)
      if cache[buf_id] ~= nil then return false end

      local path = get_buf_realpath(buf_id)
      if path == '' then return false end

      return start_watching(buf_id, path)
    end,
    detach = function(buf_id)
      invalidate_cache(buf_id)
    end,
  }
})
require('mini.pick').setup({
  mappings = {
    delete_left = nil,
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
  }
})
MiniPick.registry.my_buffers = function()
  local items, cwd = {}, vim.fn.getcwd()
  local cur_buf_id = vim.api.nvim_get_current_buf()
  for _, buf_info in ipairs(vim.fn.getbufinfo()) do
    if buf_info.listed == 1 and buf_info.bufnr ~= cur_buf_id then
      local name = vim.fs.relpath(cwd, buf_info.name) or buf_info.name
      table.insert(items, { text = name, bufnr = buf_info.bufnr, _lastused = buf_info.lastused })
    end
  end

  table.sort(items, function(a, b) return a._lastused > b._lastused end)

  local show = function(buf_id, items_to_show, query)
    MiniPick.default_show(buf_id, items_to_show, query, { show_icons = true })
  end
  local opts = { source = { name = 'Buffers', items = items, show = show } }
  return MiniPick.start(opts)
end
require('mini.notify').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require("mason-nvim-dap").setup({
  handlers = {},
  ensure_installed = {},
  automatic_installation = false,
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "lua", "vimdoc", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require('tmux').setup()

require('blink.cmp').setup({
  keymap = { preset = 'enter' }
})

require('oil').setup({
  -- add q to quite oil
  keymaps = {
    ['q'] = {
      callback = 'actions.close',
      mode = 'n',
    }
  }
})

require('atone').setup()

-- annoying adding closing keymaps to diffview
require('diffview').setup({
  use_icons = false,
  keymaps = {
    view = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    diff1 = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    diff2 = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    diff3 = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    diff4 = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    file_panel = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    file_history_panel = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
    option_panel = {
      { 'n', 'q',     '<cmd>DiffviewClose<CR>' },
      { 'n', '<Esc>', '<cmd>DiffviewClose<CR>' },
    },
  }
})

require('jj').setup()

require('toggleterm').setup()

require('lazydev').setup()

vim.cmd('colorscheme gruvbox')

vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>')

vim.keymap.set('n', '<c-h>', require('tmux').move_left, {
  desc = "move focus left"
})
vim.keymap.set('n', '<c-l>', require('tmux').move_right, {
  desc = "move focus right"
})
vim.keymap.set('n', '<c-j>', require('tmux').move_bottom, {
  desc = "move focus bottom"
})
vim.keymap.set('n', '<c-k>', require('tmux').move_top, {
  desc = "move focus top"
})

vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files)
vim.keymap.set('n', '<leader><leader>', MiniPick.registry.my_buffers)
vim.keymap.set('n', '<leader>sg', MiniPick.builtin.grep_live)
-- TODO: see how to reintroduce lsp helpers using mini pick
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', '-', '<cmd>Oil<CR>')
-- TODO: dap keymaps
vim.keymap.set('n', '<leader>u', '<cmd>Atone<CR>')

vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=float dir=.<CR>')
