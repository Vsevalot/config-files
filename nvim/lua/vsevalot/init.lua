require("vsevalot.core")
require("vsevalot.lazy")

vim.opt.wrap = false
vim.o.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.diagnostic.config({ virtual_text = true })
return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
}
