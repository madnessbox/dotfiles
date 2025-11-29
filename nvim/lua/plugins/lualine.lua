require("lualine").setup({
    options = {
        theme = "catppuccin",
        icons_enable = true,
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
