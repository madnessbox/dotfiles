local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
    -- LSP / Mason
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", dependencies = { "mason.nvim" } },
    { "neovim/nvim-lspconfig" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.telescope")
        end,
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- Nvim-Tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.nvimtree")
        end,
    },

    -- Auto pairs
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    }

    -- UI Improvements
    { 
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    },

    { "folke/which-key.nvim", config = true },

    { 
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                styles = {
                    comments = { "italic" },
                    conditionas = { "italic" },
                },
            })
            vim.cmd.colorscheme("catppuccin")
            vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        end,
    },
})
