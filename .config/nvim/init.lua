vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '

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

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.87
  vim.keymap.set({ "n", "v" }, "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end)
  vim.keymap.set({ "n", "v" }, "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end)
  vim.keymap.set({ "n", "v" }, "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end

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

-- plugins
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/rebelot/kanagawa.nvim' },
  { src = 'https://github.com/vague2k/vague.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/akinsho/toggleterm.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua', },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/linrongbin16/lsp-progress.nvim' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
  { src = 'https://github.com/igorlfs/nvim-dap-view', },
  { src = 'https://github.com/mikesmithgh/kitty-scrollback.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/sindrets/diffview.nvim' },
  { src = 'https://github.com/aserowy/tmux.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/archibate/lualine-time' },
  { src = 'https://github.com/vyfor/cord.nvim' },
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1.6.0'
  },
})
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "lua", "vimdoc", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
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
require('nvim-tree').setup()
require("tmux").setup()
require('kitty-scrollback').setup({
  paste_window = {
    yank_register_enabled = false
  }
})
require('mason').setup()
require("mason-nvim-dap").setup({
  handlers = {}
})
require('mason-lspconfig').setup()
require('lsp-progress').setup()
require('lualine').setup({
  sections = {
    lualine_z = {
      'ctime',
    }
  }
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
require('blink.cmp').setup({
  keymap = { preset = 'enter' }
})
-- kanagawa fix goofy background
require('vague').setup({})
require('kanagawa').setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  }
})
require('fzf-lua').setup({
  fzf_colors = true,
})
require('dap-view').setup({
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
  }
})
require('toggleterm').setup()
require('gitsigns').setup()
-- auto open dap view on dap attach and close dap view on terminate
require('dap').listeners.before.attach.dapui_config = function()
  vim.cmd("DapViewOpen")
end
require('dap').listeners.before.launch.dapui_config = function()
  vim.cmd("DapViewOpen")
end
require('dap').listeners.before.event_terminated.dapui_config = function()
  vim.cmd("DapViewClose")
end
require('dap').listeners.before.event_exited.dapui_config = function()
  vim.cmd("DapViewClose")
end

vim.fn.sign_define('DapBreakpoint', {
  text = '',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = ''
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(opts)
    if opts.data.spec.name == 'cord.nvim' and opts.data.kind == 'update' then
      vim.cmd 'Cord update'
    end
  end
})

vim.lsp.enable('slangd')

-- colorscheme
vim.cmd('colorscheme vague')

-- keymaps
vim.keymap.set('n', '<C-h>', require("tmux").move_left, { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', require("tmux").move_right, { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', require("tmux").move_bottom, { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', require("tmux").move_top, { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep)
vim.keymap.set('n', '<leader>ss', require('fzf-lua').lsp_live_workspace_symbols)
vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_workspace)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ca', require('fzf-lua').lsp_code_actions)
vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references)
vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations)
vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers)
vim.keymap.set('n', '-', '<cmd>Oil<CR>')
vim.keymap.set('n', '<F5>', require('dap').continue)
vim.keymap.set('n', '<F10>', require('dap').step_over)
vim.keymap.set('n', '<F11>', require('dap').step_into)
vim.keymap.set('n', '<F23>', require('dap').step_out)
vim.keymap.set('n', '<F9>', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<Right>', require('dap').down)
vim.keymap.set('n', '<Left>', require('dap').up)
vim.keymap.set('n', 'dt', function()
  require('dap').terminate()
  vim.cmd('DapViewClose')
end)
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=float dir=.<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
--    [[<cmd>lua require("tmux").next_window()<cr>]],
--    [[<cmd>lua require("tmux").previous_window()<cr>]],
