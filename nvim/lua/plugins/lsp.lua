require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 
      "clangd", 
      "lua_ls" 
  },
})

local lspconfig = require("lspconfig")

vim.diagnostics.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insdert = false,
})

vim.opt.updatetime = 300

vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusList" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "K", vim.lsp.buf.hover, opts)

  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<C-.>", vim.lsp.buf.code_action, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  map("n", "<F8>", vim.diagnostic.goto_prev, opts)
  map("n", "<S-F8>", vim.diagnostic.goto_next, opts)

  map("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

lspconfig.clangd.setup({ 
    on_attach = on_attach 
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
          enable = false,
      },
    },
  },
})
