vim.o.clipboard = 'unnamedplus'

vim.pack.add({
  { src = 'https://github.com/mikesmithgh/kitty-scrollback.nvim' }
})

local autocmds = require("kitty-scrollback.autocommands")
autocmds.set_term_enter_autocmd = function(_) end
autocmds.set_yank_post_autocmd = function() end

require("kitty-scrollback").setup({ keymaps_enabled = false })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
