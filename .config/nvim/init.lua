vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.nu = true
vim.o.rnu = true
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.confirm = true
vim.o.wildmenu = true
vim.o.scrolloff = 10
vim.o.background = "dark"
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
		},
	},
	update_in_insert = false,
})

vim.fn.sign_define("DapBreakpoint", {
	text = "",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.pack.add({
	-- colorschemes
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },

	-- lsp dap (Mason to install lsp's)
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
	{ src = "https://github.com/igorlfs/nvim-dap-view" },

	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	{ src = "https://github.com/aserowy/tmux.nvim" },

	-- completions
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.8.0",
	},

	{ src = "https://github.com/stevearc/oil.nvim" },

	{ src = "https://github.com/XXiaoA/atone.nvim" },

	{ src = "https://github.com/ibhagwan/fzf-lua" },

	{ src = "https://github.com/esmuellert/codediff.nvim" },

	{ src = "https://github.com/MunifTanjim/nui.nvim" },

	{ src = "https://github.com/sivansh11/jj" },

	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	{ src = "https://github.com/NickvanDyke/opencode.nvim.git" },

	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	{ src = "https://github.com/t-troebst/perfanno.nvim.git" },

	{ src = "https://github.com/stevearc/conform.nvim.git" },

	-- not needed
	-- { src = 'https://github.com/vimpostor/vim-tpipeline' }, -- only needed when in tmux
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/NStefan002/screenkey.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/vyfor/cord.nvim.git" },
	{ src = "https://github.com/daedlock/matugen.nvim.git" },
	{ src = "https://github.com/RRethy/base16-nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
})

require("matugen").setup()

require("cord").setup({})

require("notify").setup({
	background_colour = "#00000000",
})
vim.notify = require("notify")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		cpp = { "clang-format", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

require("gruvbox").setup({
	transparent_mode = true,
	overrides = {
		SignColumn = { link = "Normal" },
	},
})

require("dap-view").setup({
	winbar = {
		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
	},
})

require("perfanno").setup()

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
	handlers = {},
	ensure_installed = {},
	automatic_installation = false,
})

-- require('tabout').setup()

require("nvim-treesitter").install({ "cpp" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("fzf-lua").setup({
	fzf_opts = {
		-- ['--color'] = 'bg:-1,bg+:-1',
	},
	winopts = {
		-- split = "aboveleft new",
		preview = {
			hidden = true,
		},
	},
	fzf_colors = {
		["bg"] = { "bg", "Normal" },
	},
})
require("fzf-lua").register_ui_select()

require("gitsigns").setup({
	-- Ensure the blame feature is configured
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- Position: 'eol' (end of line), 'overlay', or 'right_align'
		delay = 100, -- Delay before the blame appears when idle
	},
})

require("tmux").setup()

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
	},
})

require("oil").setup({
	-- add q to quite oil
	keymaps = {
		["q"] = {
			callback = "actions.close",
			mode = "n",
		},
	},
})

require("atone").setup()

-- annoying adding closing keymaps to diffview
require("codediff").setup({})

require("jj").setup({
	keymaps = {
		log = {
			close = "q",
			close_esc = "<Esc>",
			edit = "<CR>",
			edit_immutable = "<S-CR>",
			undo = "u",
			redo = "<C-r>",
			new = "n",
			describe = "d",
			describe_immutable = "D",
			squash = "s",
			squash_immutable = "<S-s>",
			set_revset = "r",
			bookmark = "b",
			abandon = "a",
			abandon_immutable = "<S-a>",
			diff = "d", -- visual mode
			new_merge = "n", -- visual mode
			rebase = "m",
			rebase_immutable = "<S-m>",
			push = "p",
			fetch = "f",
			split = "<C-s>",
			split_immutable = "<C-S-s>",
			disabled = { "i", "c" }, -- keys mapped to no-op
		},
		status = {
			close = "q",
			close_esc = "<Esc>",
			open_file = "<CR>",
			disabled = { "i", "c", "a" },
		},
		rebase = {
			close = "q",
			close_esc = "<Esc>",
			rebase_to = "<CR>",
			rebase_to_immutable = "<S-CR>",
			disabled = { "i", "c", "a" },
		},
	},
})

require("toggleterm").setup()

require("lazydev").setup()

require("screenkey").setup()

-- vim.cmd.colorscheme("matugen")
vim.cmd.colorscheme("kanagawa")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<c-h>", require("tmux").move_left, {
	desc = "move focus left",
})
vim.keymap.set("n", "<c-l>", require("tmux").move_right, {
	desc = "move focus right",
})
vim.keymap.set("n", "<c-j>", require("tmux").move_bottom, {
	desc = "move focus bottom",
})
vim.keymap.set("n", "<c-k>", require("tmux").move_top, {
	desc = "move focus top",
})

vim.keymap.set("n", "<leader>cf", require("conform").format)
vim.keymap.set("n", "<leader>sf", require("fzf-lua").files)
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep)
vim.keymap.set("n", "<leader>ss", require("fzf-lua").lsp_live_workspace_symbols)
vim.keymap.set("n", "<leader>sd", require("fzf-lua").diagnostics_workspace)
vim.keymap.set("n", "<leader>sR", require("fzf-lua").lsp_references)
vim.keymap.set("n", "<leader>sr", require("fzf-lua").resume)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>Atone<CR>")

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float dir=.<CR>")

vim.keymap.set("n", "<leader>j", "<cmd>J<CR>")

-- dap keymaps
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F23>", require("dap").step_out)
vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<Right>", require("dap").down)
vim.keymap.set("n", "<Left>", require("dap").up)
vim.keymap.set("n", "dt", function()
	require("dap").terminate()
	vim.cmd("DapViewClose")
end)

vim.keymap.set({ "n", "x" }, "<leader>oc", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })

-- auto open dap view on dap attach and close dap view on terminate
require("dap").listeners.before.attach.dapui_config = function()
	vim.cmd("DapViewOpen")
end
require("dap").listeners.before.launch.dapui_config = function()
	vim.cmd("DapViewOpen")
end
require("dap").listeners.before.event_terminated.dapui_config = function()
	vim.cmd("DapViewClose")
end
require("dap").listeners.before.event_exited.dapui_config = function()
	vim.cmd("DapViewClose")
end
