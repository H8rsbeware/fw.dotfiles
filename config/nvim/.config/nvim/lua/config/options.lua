--- vim.opt.clipboard = "unnamedplus"


-- cmd completion
vim.opt.wildmenu = true
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = { "pum", "fuzzy" }

-- essentials

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.ignorecase = true
vim.opt.smartcase = true

--- no silly vim indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

--- no swap, use undo tree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

--- colours
vim.opt.termguicolors = true

--- scroll
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

--- misc
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

--- leader
vim.g.mapleader = " "
