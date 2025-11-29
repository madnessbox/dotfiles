require("nvim-tree").setup({
    sort_by = "name",
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    filters = {
        dotfiles = false,
    },
    actions = {
        open_file = {
            quit_on_open = false ,
            resize_window = true,
        },
    },
    git = { enable = true },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
})

vim.keymap.set("n", "<A-1>", "<cmd>NvimTreeFindFileToggle<CR>", { 
    noremap = true,
    silent = true,
    desc = "Toggle file tree (Alt+1)"
})

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = "none", bg = "none" })

