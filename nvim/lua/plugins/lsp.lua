require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls" },
})

local lspconfig = require("lspconfig")

-- Basic on_attach: customize keymaps per buffer
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
end

lspconfig.clangd.setup({ on_attach = on_attach })
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
