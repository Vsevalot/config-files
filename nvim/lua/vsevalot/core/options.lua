vim.cmd("let g:netrw_liststyle = 3") -- changes file explorer to tree
vim.g.have_nerd_font = true

local opt = vim.opt
opt.clipboard = "unnamedplus"

-- enable nubers and activate relative numbers
opt.number = true
-- opt.relativenumber = true

opt.splitbelow = true -- change horizontal split to spawn new split below
opt.splitright = true -- change vertical split to spawn new split on the right

opt.wrap = false
opt.cursorline = true

opt.expandtab = true -- change tabs to spaces
opt.tabstop = 2 -- sets tab's length
opt.shiftwidth = 2 -- sets shit's length (> or <)

-- this option breaks mouse a little
opt.scrolloff = 5 -- keep screen in the middle when scrolling instead of going all way to the bottom
-- opt.cmdheight = 2

opt.virtualedit = "block" -- allow VISUAL BLOCK mode to select ares without any characters

opt.inccommand = "split" -- preview of replace in the split

opt.ignorecase = true -- case insesetive autocomplete for commands

opt.termguicolors = true -- allow to use all system colors

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
