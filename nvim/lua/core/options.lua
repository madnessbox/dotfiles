local opt = vim.opt
local g = vim.g

-- leader keys
g.mapleader = " "
g.maplocalleader = " "

-- line numbers
opt.number = true
opt.relativenumber = true

-- indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- text behavior
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

-- search
opt.hlsearch = false
opt.incsearch = true

-- performance
opt.updatetime = 50
opt.swapfile = false
opt.backup = false

-- appearance
opt.termguicolors = true
opt.cmdheight = 0  -- hides commandline when unused (Neovim >= 0.9)

-- ensure system clipboard integration
opt.clipboard = "unnamedplus"
