return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    init = function()
        -- Prevent Python's built-in function mappings from competing.
        vim.g.no_python_maps = true
    end,

    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
                selection_modes = {
                    ["@function.outer"] = "V",
                    ["@function.inner"] = "V",
                },
            },
            move = { set_jumps = true },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")

        local function object(keys, query, description)
            vim.keymap.set({ "x", "o" }, keys, function()
                select.select_textobject(query, "textobjects")
            end, { desc = description })
        end

        object("af", "@function.outer", "Around function")
        object("if", "@function.inner", "Inside function")
        object("al", "@loop.outer", "Around loop")
        object("il", "@loop.inner", "Inside loop")
        object("ai", "@conditional.outer", "Around conditional")
        object("ii", "@conditional.inner", "Inside conditional")
        object("aa", "@parameter.outer", "Around argument/parameter")
        object("ia", "@parameter.inner", "Inside argument/parameter")

        local function motion(keys, method, query, description)
            vim.keymap.set({ "n", "x", "o" }, keys, function()
                move[method](query, "textobjects")
            end, { desc = description })
        end

        motion("]m", "goto_next_start", "@function.outer", "Next function start")
        motion("[m", "goto_previous_start", "@function.outer", "Previous function start")
        motion("]M", "goto_next_end", "@function.outer", "Next function end")
        motion("[M", "goto_previous_end", "@function.outer", "Previous function end")
        motion("]l", "goto_next_start", "@loop.outer", "Next loop")
        motion("[l", "goto_previous_start", "@loop.outer", "Previous loop")
        motion("]i", "goto_next_start", "@conditional.outer", "Next conditional")
        motion("[i", "goto_previous_start", "@conditional.outer", "Previous conditional")

        local blocks = { "@loop.outer", "@conditional.outer" }
        motion("]s", "goto_next_start", blocks, "Next loop or conditional")
        motion("[s", "goto_previous_start", blocks, "Previous loop or conditional")
    end,
}
