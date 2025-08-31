vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

local function pytest_to_buffer()
  -- vim.fn.expand('%:p') gets the full path of the current buffer
  local filepath = vim.fn.expand("%")
  if filepath == "" then
    print("No file path associated with this buffer.")
    return
  end
  local command_to_copy = "pdm run pytest -vv " .. filepath
  -- Set the system clipboard register '+'
  -- vim.fn.setreg requires a table of strings (lines)
  vim.fn.setreg("+", { command_to_copy })

  -- Notify the user (optional but helpful)
  print("Copied command for tests")
end

keymap.set("n", "<leader>et", function()
  pytest_to_buffer()
end, {
  noremap = true, -- Already default, but good to be explicit when learning
  silent = true,
  desc = "Copy command to run test", -- Add a description
})
