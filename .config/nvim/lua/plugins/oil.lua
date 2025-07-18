return {
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Oil file manager" },
  },
  opts = {
    keymaps = {
      ["q"] = {
        callback = "actions.close",
        mode = "n", -- 'n' ensures this mapping only applies in Normal mode
      },
    },
  },
  -- ---@module 'oil'
  -- ---@type oil.SetupOpts
  -- config = function()
  --   require("oil").setup()
  --   vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "oil" })
  -- end,
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
