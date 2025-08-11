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

-- plugins
vim.pack.add({
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/rebelot/kanagawa.nvim' },
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1.6.0'
  },
  { src = 'https://github.com/ibhagwan/fzf-lua', },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
  { src = 'https://github.com/igorlfs/nvim-dap-view' },
  { src = 'https://github.com/akinsho/toggleterm.nvim' },
})
require('mason').setup()
require("mason-nvim-dap").setup({
  handlers = {}
})
require('mason-lspconfig').setup()
-- add q to quite oil
require('oil').setup({
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
require('dap-view').setup()
require("toggleterm").setup()

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
require('dap').defaults.fallback.switchbuf = 'useopen,usetab,uselast'

-- colorscheme
vim.cmd('colorscheme kanagawa')

-- keymaps
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep)
vim.keymap.set('n', '<leader>ss', require('fzf-lua').lsp_live_workspace_symbols)
vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_workspace)
vim.keymap.set('n', 'grr', require('fzf-lua').lsp_references)
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers)
vim.keymap.set('n', '-', '<cmd>Oil<CR>')
vim.keymap.set('n', '<F5>', require('dap').continue)
vim.keymap.set('n', '<F10>', require('dap').step_over)
vim.keymap.set('n', '<F11>', require('dap').step_into)
vim.keymap.set('n', '<F23>', require('dap').step_out)
vim.keymap.set('n', '<F9>', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<Right>', require('dap').down)
vim.keymap.set('n', '<Left>', require('dap').up)
vim.keymap.set('n', 'dt', function ()
  require('dap').terminate()
  vim.cmd('DapViewClose')
end)
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=float dir=.<CR>')
