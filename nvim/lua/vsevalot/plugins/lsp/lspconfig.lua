return {
  "neovim/nvim-lspconfig",
  tag = "v2.2.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        local opts_for_gr = {
          buffer = ev.buf,
          silent = true,
          noremap = true, -- Ensure noremap is also here
          nowait = true,
        }

        opts_for_gr.desc = "Show LSP references"
        keymap.set("n", "gr", function()
          vim.notify(
            "GR (LspAttach Lua fn with nowait): Finding references for buffer " .. ev.buf,
            vim.log.levels.INFO,
            { title = "Keymap" }
          )
          require("telescope.builtin").lsp_references({})
        end, opts_for_gr)
        -- -- set keybinds
        -- opts.desc = "Show LSP references"
        -- keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts_for_gr) -- show diagnostics for line
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local function toggle_virtual_text()
      local current_config = vim.diagnostic.config()
      vim.diagnostic.config({
        virtual_text = not current_config.virtual_text,
      })
      if not current_config.virtual_text then
        vim.notify("Virtual text enabled", vim.log.levels.INFO, { title = "Diagnostics" })
      else
        vim.notify("Virtual text disabled", vim.log.levels.INFO, { title = "Diagnostics" })
      end
    end

    -- 3. Set up the keymap `fz` to toggle virtual text
    vim.keymap.set(
      "n",
      "<leader>t",
      toggle_virtual_text,
      { noremap = true, silent = true, desc = "Toggle diagnostic virtual text" }
    )

    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = false,
          },
          venvPath = ".venv",
          pythonPath = ".venv/bin/python",
        },
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })
  end,
}
