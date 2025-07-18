return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        -- This is the master switch. Set to false for manual triggering. [3, 7]
        auto_trigger = true,
        -- The keymap table within `suggestion` is for the plugin's internal handling,
        -- but we will define our own robust keymaps below for better control.
        -- It's good practice to clear these to avoid conflicts with our custom maps.
        keymap = {
          accept = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      -- Configuration for filetypes. By default, it's enabled for most common ones.
      -- This example shows how to explicitly enable/disable for specific types. [3]
      filetypes = {
        -- yaml = false,
        -- markdown = true,
        -- help = false,
        ["*"] = true, -- Enable for all other filetypes
      },
    })

    -- ########################################################################
    -- ##  COMPLETE ON-DEMAND KEYMAP SCHEME                                  ##
    -- ########################################################################
    -- This section implements the full, ergonomic keymap scheme discussed.
    -- It uses custom functions for maximum control and context-awareness.

    local map = vim.keymap.set

    map("i", "<C-a>", function()
      require("copilot.suggestion").next()
    end, { desc = "Copilot: Trigger Next Suggestion", silent = true })

    -- Dismiss the current suggestion
    map("i", "<C-e>", function()
      require("copilot.suggestion").dismiss()
    end, { desc = "Copilot: Dismiss Suggestion", silent = true })

    -- Context-aware Tab for accepting suggestions
    -- This is the recommended way to handle the Tab key. [14]
    map("i", "<Tab>", function()
      if require("copilot.suggestion").is_visible() then
        -- If a suggestion is visible, accept it.
        require("copilot.suggestion").accept()
      else
        -- Otherwise, insert a literal Tab character.
        -- This uses feedkeys to simulate the keypress.
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end, { desc = "Copilot: Accept Suggestion or Tab", silent = true })

    -- Cycle through suggestions using the plugin's default keys

    map("i", "<M-]>", function()
      require("copilot.suggestion").next()
    end, { desc = "Copilot: Next Suggestion", silent = true })
  end,
}
