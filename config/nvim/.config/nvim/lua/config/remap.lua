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

-- other helpful diagnostics and lsp opts -- 
local telescope = require("telescope.builtin")
local def_opts = {
    silent = true,
}

-- lsp
vim.keymap.set("n", "gd", telescope.lsp_definitions)
vim.keymap.set("n", "gr", telescope.lsp_references)
vim.keymap.set("n", "gI", telescope.lsp_implementations)

vim.keymap.set("n", "K", vim.lsp.buf.hover, def_opts )
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, def_opts)

vim.keymap.set("n", "gD", "<cmd>Glance definitions<CR>")
vim.keymap.set("n", "gR", "<cmd>Glance references<CR>")
vim.keymap.set("n", "gI", "<cmd>Glance implementations<CR>")
vim.keymap.set("n", "gT", "<cmd>Glance type_definitions<CR>")

-- symbols
vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename, def_opts )
vim.keymap.set("n", "<leader>sd", telescope.lsp_document_symbols)
vim.keymap.set("n", "<leader>sw", telescope.lsp_dynamic_workspace_symbols)

-- errors/diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>el", function()
    vim.diagnostics.setloclist()
    vim.cmd.lopen()
end, { silent = false })

-- ic and oc
vim.keymap.set("n", "<leader>ic", telescope.lsp_incoming_calls)
vim.keymap.set("n", "<leader>oc", telescope.lsp_outgoing_calls)

