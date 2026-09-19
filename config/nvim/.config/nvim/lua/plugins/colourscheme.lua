return {
    {
        "b0o/lavi",
        lazy = false,
        priority = 1000,

        config = function()
            vim.g.lavi_config = {
                transparent = true,
            }

            vim.cmd.colorscheme("lavi-deep-ember")
        end,
    },
}
