-- ============================================================================
-- NULL-LS CONFIGURATION MODULE
-- ============================================================================
-- This module provides formatter and linter integration for Neovim
-- using null-ls (now nvim-lint and conform.nvim, but null-ls is still valid)

return {
  'nvimtools/none-ls.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require('null-ls')

    -- =====================================================================
    -- FORMATTING SOURCES
    -- =====================================================================
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        formatting.shfmt,
      },

      -- ====================================================================
      -- FORMATTING BEHAVIOR
      -- ====================================================================
      on_attach = function(client, bufnr)
        -- Auto-format on save for all attached buffers
        if client.supports_method('textDocument/formatting') then
          local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = false })
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })

    -- =====================================================================
    -- FORMATTER KEYBINDING
    -- =====================================================================
    -- Manual format with <leader>bf (buffer format)
    vim.keymap.set('n', '<leader>bf', function()
      vim.lsp.buf.format()
    end, { noremap = true, silent = true, desc = 'Format buffer (null-ls)' })
  end
}
