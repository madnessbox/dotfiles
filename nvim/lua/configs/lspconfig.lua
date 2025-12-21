require("nvchad.lsp").diagnostic_config()

-- Smart gd mapping (go to definition, or if already there, show references)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if not client then
      return
    end

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "gi", function()
      local builtin = require("telescope.builtin")
      builtin.lsp_implementations()
    end, { buffer = bufnr, desc = "Find implementations (Telescope)" })

    vim.keymap.set("n", "gr", function()
      builtin.lsp_references()
    end, { buffer = bufnr, desc = "List References (Telescope)" })

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
      buffer = bufnr,
      desc = "Go to Declaration",
    })

    vim.keymap.set("n", "gd", function()
      -- Use new LSP client API
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      local lsp = clients[1]
      if not lsp then
        vim.notify("No LSP client attached", vim.log.levels.WARN)
        return
      end

      -- Provide position encoding (Neovim 0.11+ requirement)
      local params = vim.lsp.util.make_position_params(
        nil,
        lsp.offset_encoding or "utf-16"
      )

      lsp.request("textDocument/definition", params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then
          vim.notify("No definition found", vim.log.levels.INFO)
          return
        end

        local def = result[1]
        local uri = def.uri or def.targetUri
        local range = def.range or def.targetSelectionRange
        local curr_uri = vim.uri_from_bufnr(bufnr)
        local curr_row = vim.api.nvim_win_get_cursor(0)[1] - 1

        -- If at definition, open Telescope references
        if uri == curr_uri and math.abs(curr_row - range.start.line) <= 1 then
          builtin.lsp_references()
        else
          vim.lsp.util.jump_to_location(def, lsp.offset_encoding)
        end
      end, bufnr)
    end, { buffer = bufnr, desc = "Smart Go to Definition / References" })

    vim.keymap.set({ "n", "v" }, "<leader>ca", function()
      -- Try normal code actions, but if Telescope is available, use it
      local has_actions = vim.lsp.buf.code_action
      if has_actions then
        -- Use Telescope if preferred
        local ok, _ = pcall(builtin.lsp_code_actions)
        if not ok then
          vim.lsp.buf.code_action()
        end
      end
    end, { buffer = bufnr, desc = "Code Action (Smart)" })

    -- Quick Fix variant
    vim.keymap.set("n", "<leader>qf", function()
      vim.lsp.buf.code_action({
        context = { only = { "quickfix", "refactor", "source.organizeImports" } },
        apply = true,
      })
    end, { buffer = bufnr, desc = "Apply Quick Fix / Organize Imports" })
  end,
})

-- Normal LSP server loading
local servers = { "html", "cssls", "clangd", "cmake" }
vim.lsp.enable(servers)
