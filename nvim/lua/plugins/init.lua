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
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- other
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
})
