-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
-- This file sets up language server protocol (LSP) integration with Mason
-- for package management and automatic installation of LSP servers.

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION (single authoritative source)
-- ============================================================================
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
})

-- ============================================================================
-- MASON SETUP (Package Manager for LSP Servers)
-- ============================================================================
-- Mason automatically installs and manages LSP servers, formatters, and linters
require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

-- ============================================================================
-- MASON-LSPCONFIG SETUP
-- ============================================================================
-- Bridges Mason with lspconfig to auto-install servers and wire up their configs
require('mason-lspconfig').setup({
  -- Servers to automatically install (rust-analyzer managed by rustaceanvim)
  ensure_installed = {
    'bashls',
    'clangd',
    'pylsp',
    'pyright',
  },
  automatic_enable = false,
})

-- ============================================================================
-- NVIM-LSPCONFIG SETUP
-- ============================================================================
-- -- Pylsp Config:
-- vim.lsp.config('pylsp', {
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = {'W391', 'E128', 'E203', 'E225', 'E302', 'E251', 'E252', 'E501', 'E701',},
--           maxLineLength = 120
--         },
--         pydocstyle = { enabled = false },
--         rope_completion = { enabled = false },
--         rope_autoimport = { enabled = false },
--         yapf = { enabled = false }
--       }
--     }
--   }
-- })
--
-- -- Activate Pylsp
-- vim.lsp.enable('pylsp')

-- Pyright Config:
vim.lsp.config('pyright', {
  settings = {
    python = {
      analysis = {

      }
    }
  }
})

-- Activate Pyright
vim.lsp.enable('pyright')

-- Lua_Ls Config:
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable('lua_ls')

-- Enable LS with default settings:
vim.lsp.enable('bash_ls')
vim.lsp.enable('clangd')

