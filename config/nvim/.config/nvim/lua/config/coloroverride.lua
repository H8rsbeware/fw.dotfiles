local function set_completion_colors()
    vim.api.nvim_set_hl(0, "Pmenu", {
        bg = "#111118",
        fg = "#a6adc8",
    })

    vim.api.nvim_set_hl(0, "PmenuSel", {
        bg = "#181825",
        fg = "#cba6f7",
        bold = true,
    })

    vim.api.nvim_set_hl(0, "PmenuSbar", {
        bg = "#181825",
    })

    vim.api.nvim_set_hl(0, "PmenuThumb", {
        bg = "#8f849e",
    })

    vim.api.nvim_set_hl(0, "PmenuMatch", {
        fg = "#cba6f7",
        bold = true,
    })

    vim.api.nvim_set_hl(0, "PmenuMatchSel", {
        fg = "#cba6f7",
        bold = true,
    })
end

local function set_error_colors()
    local error_red = "#f38ba8"
    
    -- Diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticError", {
        fg = error_red,
        bg = "NONE",
    })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
        fg = error_red,
        bg = "NONE",
    })

    vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {
        fg = error_red,
        bg = "NONE",
    })

    vim.api.nvim_set_hl(0, "DiagnosticSignError", {
        fg = error_red,
        bg = "NONE",
    })


    -- Console
    vim.api.nvim_set_hl(0, "StderrMsg", {
        fg = error_red,
        bg = "NONE",
    })

    vim.api.nvim_set_hl(0, "ErrorMsg", {
        fg = error_red,
        bg = "NONE",
    })
end

local function set_all_override_colors()
    set_completion_colors()
    set_error_colors()
end

set_all_override_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback=set_all_override_colors
})
