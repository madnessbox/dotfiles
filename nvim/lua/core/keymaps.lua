local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Leader settings already in options.lua

-- Clear highlight
map("n", "<leader>h", "<cmd>nohlsearch<CR>", default_opts)

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", default_opts)
map("v", "K", ":m '<-2<CR>gv=gv", default_opts)

-- Keep cursor centered
map("n", "J", "mzJ`z", default_opts)
map("n", "<C-d>", "<C-d>zz", default_opts)
map("n", "<C-u>", "<C-u>zz", default_opts)
map("n", "n", "nzzzv", default_opts)
map("n", "N", "Nzzzv", default_opts)

-- Paste over selection without overwriting register
map("x", "<leader>p", '"_dP', default_opts)

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', default_opts)
map("n", "<leader>Y", '"+Y', default_opts)
map({ "n", "v" }, "<leader>d", '"_d', default_opts)

-- Quickfix navigation
map("n", "<C-k>", "<cmd>cnext<CR>zz", default_opts)
map("n", "<C-j>", "<cmd>cprev<CR>zz", default_opts)
map("n", "<leader>k", "<cmd>lnext<CR>zz", default_opts)
map("n", "<leader>j", "<cmd>lprev<CR>zz", default_opts)

-- LSP code action (will work once LSP loads)
map("n", "<leader>ca", vim.lsp.buf.code_action, default_opts)

-- Replace current word in file
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", default_opts)

-- chmod +x current file
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", default_opts)

-- Window navigation (Alt + hjkl)
map("n", "<A-h>", "<C-w>h", default_opts)
map("n", "<A-j>", "<C-w>j", default_opts)
map("n", "<A-k>", "<C-w>k", default_opts)
map("n", "<A-l>", "<C-w>l", default_opts)
