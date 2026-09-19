vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--- pum
vim.opt.pumheight = 8
vim.opt.pummaxwidth = 60

--- auto move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


--- J keeps cursor at start
vim.keymap.set("n", "J", "mzJ`z")

--- half page jumps stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--- same for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--- paste over without copy
vim.keymap.set("x", "<leader>p", "\"_dP")

--- copy buffer outside vim
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--- delete to void
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")


--- got told to unbind this
vim.keymap.set("n", "Q", "<nop>")

--- lsp formatter
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

--- replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--- chmod
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
