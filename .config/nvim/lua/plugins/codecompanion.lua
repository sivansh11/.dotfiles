return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion", "CodeCompanionChat" },
  keys = { { "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "[A][I]" } },
  -- lazy = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim" },
    "ravitemer/mcphub.nvim",
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      },
    },
    -- {
    --   "saghen/blink.cmp",
    --   lazy = false,
    --   version = "*",
    --   opts = {
    --     keymap = {
    --       preset = "enter",
    --       ["<S-Tab>"] = { "select_prev", "fallback" },
    --       ["<Tab>"] = { "select_next", "fallback" },
    --     },
    --     cmdline = { sources = { "cmdline" } },
    --     sources = {
    --       default = { "lsp", "path", "buffer", "codecompanion" },
    --     },
    --   },
    -- },
    -- Test with nvim-cmp
    -- { "hrsh7th/nvim-cmp" },
  },
  opts = {
    adapters = {
      llamacpp = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "llamacpp",
          formatted_name = "llamacpp",
          schema = {
            -- model = {
            --   default = "cogito-3b",
            -- },
          },
          env = {
            url = "http://localhost:8012",
          },
          handlers = {
            chat_output = function(self, data)
              print("test")
              local openai = require("codecompanion.adapters.openai")
              local result = openai.handlers.chat_output(self, data)
              if result ~= nil then
                result.output.role = "llm" -- "assistant"  works as well
              end
              return result
            end,
          },
        })
      end,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "custom-qwen3:0.6b",
            },
          },
        })
      end,
      qwen = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = "custom-qwen3:0.6b",
            },
          },
        })
      end,
    },
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      chat = { adapter = "gemini" },
      inline = { adapter = "gemini" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
