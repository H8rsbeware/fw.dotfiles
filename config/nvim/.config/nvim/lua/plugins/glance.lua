return {
    "dnlhc/glance.nvim",
    cmd = "Glance",

    config = function()
        require("glance").setup({
            theme = {
                enable = true,
                mode = "brighten",
            },

            border = {
                enable = true,
            },
        })
    end,
}
