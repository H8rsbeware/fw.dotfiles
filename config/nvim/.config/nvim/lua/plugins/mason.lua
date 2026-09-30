return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			firewall = {
				enabled = true,
				auto_managed = false,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
        opts = {
            servers = {
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                -- Prevent basedpyright from offering organize-imports actions
                                disableOrganizeImports = true,
                            },
                        },
                    },
                    -- Disable all formatting from this LSP client
                    on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                    end,
                },
            },
        },
	},
	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			ensure_installed = {
				"lua_ls",
				"basedpyright",
				"zls",
				"gopls",
				"jsonls",
				"markdown_oxide",
			}
		},
	}
}
