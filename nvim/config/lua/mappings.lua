require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({"i", "n"}, "<leader>|", "<cmd> vsplit <cr>")
map({"i", "n"}, "<C-s>", "<cmd> wa <cr>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
