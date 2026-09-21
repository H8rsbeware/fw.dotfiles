return {
    {
        "H8rsbeware/projectpad.nvim",

        opts = {
            filename = ".projectpad.md",
            size = 40,
            side = "left",
        },

        keys = {
            {
                "<leader>pp",
                function()
                    require("projectpad").open()
                end,
                desc = "Open ProjectPad",
            },
        },
    },
}
