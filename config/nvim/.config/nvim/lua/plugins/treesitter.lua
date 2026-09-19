return {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
        "neovim-treesitter/treesitter-parser-registry",
    },

    lazy = false,
    build = ":TSUpdate",

    config = function()
        local languages = {
            "zig",
	    "go",
            "dot",
            "diff",
            "markdown",
            "python",
            "zsh",
            "bash",
	    "lua",
	    "help",
        }

        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = languages,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
