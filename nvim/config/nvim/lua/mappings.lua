require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>|", "<cmd> vsplit <cr>")
map({ "i", "n" }, "<C-s>", "<cmd> wa <cr><ESC>")

-------------------
-- emac key binding
-------------------
-- Map w to the last character of word
vim.api.nvim_set_keymap('x', 'w', 'e', { noremap = true, silent = true })
-- In insert mode, map Alt + Delete to delete the previous word
vim.api.nvim_set_keymap('n', '<A-BS>', 'db', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-BS>', '<C-w>', { noremap = true, silent = true })

--In insert mode, map Alt + Delete to delete the word after the cursor
vim.api.nvim_set_keymap('i', '<A-Del>', '<C-o>dw', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Del>', 'dw', { noremap = true, silent = true })

-- In normal mode, map Backspace to delete the character before the cursor
vim.api.nvim_set_keymap('n', '<BS>', 'X', { noremap = true, silent = true })

-- In normal mode, map Delete to delete the character under the cursor
vim.api.nvim_set_keymap('n', '<Del>', 'x', { noremap = true, silent = true })
-- Ctrl V to paste
vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

-- Map r to redo
vim.api.nvim_set_keymap('n', 'r', '<C-r>', { noremap = true, silent = true })

-- LSP key map
map("n", "<A-CR>", "<cmd>Telescope lsp_definitions<cr>")
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>")
map("n", "<C-m>", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- Telescope search
vim.api.nvim_set_keymap('n', '#', ":lua require('telescope.builtin').grep_string()<CR>",
  { noremap = true, silent = true })
-- autocmd FileType qf nnoremap <buffer> <CR> <CR>
vim.api.nvim_set_keymap('n', 'x', ':lua if not vim.bo.modifiable then vim.cmd("q") end<CR>',
  { noremap = true, silent = true })
