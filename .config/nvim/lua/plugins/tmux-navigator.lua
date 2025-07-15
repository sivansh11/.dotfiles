return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>" },
    { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>" },
    { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>" },
    { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>" },
  },
  opts = {},
}
