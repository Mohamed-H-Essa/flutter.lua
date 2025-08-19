return {
  -- Customize Copilot settings
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<C-l>", -- Accept suggestion with Ctrl+l
          next = "<M-]>",   -- Next suggestion
          prev = "<M-[>",   -- Previous suggestion
          dismiss = "<C-]>", -- Dismiss suggestion
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
        yaml = true,
        json = true,
      },
    },
  },

  -- Customize Copilot Chat with <leader>C keymaps
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      auto_insert_mode = true,
      window = {
        width = 0.4,
        height = 0.6,
      },
    },
    keys = {
      -- Override default AI keymaps to use <leader>C instead
      { "<leader>a", false }, -- Disable default <leader>a
      { "<leader>aa", false },
      { "<leader>ax", false },
      { "<leader>aq", false },

      -- Custom <leader>C keymaps
      { "<leader>C", "", desc = "+copilot", mode = { "n", "v" } },
      
      -- Chat commands
      {
        "<leader>Cc",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>Cx",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear Chat",
        mode = { "n", "v" },
      },
      {
        "<leader>Cq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat",
        mode = { "n", "v" },
      },

      -- Preset prompts
      {
        "<leader>Ce",
        function()
          require("CopilotChat").ask("Explain this code", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Explain Code",
        mode = "v",
      },
      {
        "<leader>Ct",
        function()
          require("CopilotChat").ask("Write tests for this code", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Generate Tests",
        mode = "v",
      },
      {
        "<leader>Cr",
        function()
          require("CopilotChat").ask("Review this code and suggest improvements", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Review Code",
        mode = "v",
      },
      {
        "<leader>Cf",
        function()
          require("CopilotChat").ask("Fix this code", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Fix Code",
        mode = "v",
      },
      {
        "<leader>Co",
        function()
          require("CopilotChat").ask("Optimize this code for better performance", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Optimize Code",
        mode = "v",
      },
      {
        "<leader>Cd",
        function()
          require("CopilotChat").ask("Add documentation for this code", { selection = require("CopilotChat.select").visual })
        end,
        desc = "Document Code",
        mode = "v",
      },

      -- File-based commands
      {
        "<leader>Cb",
        function()
          require("CopilotChat").ask("Explain this buffer", { selection = require("CopilotChat.select").buffer })
        end,
        desc = "Explain Buffer",
      },
      {
        "<leader>Cs",
        function()
          require("CopilotChat").ask("Summarize this file", { selection = require("CopilotChat.select").buffer })
        end,
        desc = "Summarize File",
      },

      -- Panel controls
      {
        "<leader>Cp",
        function()
          require("copilot.panel").open()
        end,
        desc = "Open Panel",
      },
      {
        "<leader>CR",
        function()
          require("copilot.panel").refresh()
        end,
        desc = "Refresh Panel",
      },

      -- Copilot status and controls
      {
        "<leader>CS",
        ":Copilot status<CR>",
        desc = "Copilot Status",
      },
      {
        "<leader>Ce",
        ":Copilot enable<CR>",
        desc = "Enable Copilot",
      },
      {
        "<leader>CD",
        ":Copilot disable<CR>",
        desc = "Disable Copilot",
      },
    },
  },
}
