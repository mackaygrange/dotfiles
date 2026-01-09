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
        -- Lua formatting
        formatting.stylua.with({
          extra_args = { '--indent-type', 'Spaces', '--indent-width', '2' },
        }),

        -- Shell script formatting
        formatting.shfmt.with({
          extra_args = { '-i', '2' },  -- 2-space indentation
        }),

        -- Python formatting (Black)
        formatting.black.with({
          extra_args = { '--line-length', '120' },
        }),

        -- Python import sorting (isort)
        formatting.isort,

        -- JSON formatting
        formatting.prettier.with({
          extra_filetypes = { 'json', 'jsonc' },
          extra_args = { '--parser', 'json' },
        }),

        -- YAML formatting
        formatting.yamlfmt,

        -- Markdown formatting
        formatting.prettier.with({
          extra_filetypes = { 'markdown' },
        }),
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
    -- Manual format with <leader>f (handled in remap.lua as well)
    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format()
    end, { noremap = true, silent = true })
  end
}
