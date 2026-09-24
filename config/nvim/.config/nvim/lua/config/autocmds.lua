vim.api.nvim_create_autocmd("CmdlineChanged", {
    pattern = { ":", "/", "?" },
    callback = function()
        vim.fn.wildtrigger()
    end,
})


vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client
            and client:supports_method("textDocument/completion")
        then
            vim.lsp.completion.enable(
                true,
                client.id,
                event.buf,
                { autotrigger = true }
            )
        end

        if client 
            and client:supports_method("textDocument/inlayHint")
        then
            vim.lsp.inlay_hint.enable(true, {
                bufnr = event.buf,
            })
        end

        local opts = {
            buffer = event.buf,
            silent = true,
        }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)

        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>dsa", function()
            vim.diagnostic.setloclist()
            vim.cmd.lopen()
        end, { silent  = false })
    end,
})
