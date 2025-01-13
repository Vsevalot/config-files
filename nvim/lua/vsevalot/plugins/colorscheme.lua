return {
        "catppuccin/nvim",
        name = "cappuccin",
        priority = 1000,
        config = function() -- use callback otherwise lua will just start downloading theme and go to
            -- the use colorscheme command before finishing download
            vim.cmd.colorscheme("catppuccin-mocha")  -- command to use this cs for any nvim instance
            -- vim.cmd.colorscheme("catppuccin-latte")  -- command to use this cs for any nvim instance
            -- vim.cmd.colorscheme("shine")  -- command to use this cs for any nvim instance
        end,
    }  -- lazy assumes that plugin is from github
