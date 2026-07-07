-- ============================================================================
-- LSP ZERO CONFIGURATION
-- ============================================================================
-- This file sets up language server protocol (LSP) integration with Mason
-- for package management and automatic installation of LSP servers.

local lsp_zero = require('lsp-zero')

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
-- LSP FLOATING WINDOW BORDERS
-- ============================================================================
-- Override LSP handlers to display hover, signature help, and other popups
-- with rounded borders (similar to telescope/harpoon style)
local lsp_float_max_width = 80

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'rounded',
    max_width = lsp_float_max_width,
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = 'rounded',
    max_width = lsp_float_max_width,
  }
)

-- ============================================================================
-- LSP KEYBINDINGS & ATTACH
-- ============================================================================
-- This runs when an LSP server attaches to a buffer
lsp_zero.on_attach(function(client, bufnr)
  -- Use lsp-zero's default keybindings for the current buffer
  -- These include: gd (goto definition), gr (goto references), etc.
  lsp_zero.default_keymaps({ buffer = bufnr })

  local opts = function(desc)
    return { buffer = bufnr, remap = false, desc = desc }
  end

  -- ========================================================================
  -- HOVER & DOCUMENTATION
  -- ========================================================================
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('LSP: Hover documentation'))
  vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts('LSP: Signature help'))
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts('LSP: Signature help (insert)'))

  -- ========================================================================
  -- CODE NAVIGATION
  -- ========================================================================
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('LSP: Go to definition'))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('LSP: Go to declaration'))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts('LSP: Go to implementation'))
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts('LSP: Go to type definition'))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts('LSP: List references'))

  -- ========================================================================
  -- DIAGNOSTICS NAVIGATION
  -- ========================================================================
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts('LSP: Next diagnostic'))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts('LSP: Previous diagnostic'))
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts('LSP: Show diagnostic float'))
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts('LSP: Diagnostics to location list'))

  -- ========================================================================
  -- CODE ACTIONS & REFACTORING
  -- ========================================================================
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('LSP: Rename symbol'))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts('LSP: Code action'))
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts('LSP: Code action (visual)'))

  -- ========================================================================
  -- WORKSPACE & SYMBOL SEARCH
  -- ========================================================================
  vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts('LSP: Document symbols'))
  vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts('LSP: Workspace symbols'))
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts('LSP: Add workspace folder'))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts('LSP: Remove workspace folder'))
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts('LSP: List workspace folders'))

  -- ========================================================================
  -- INCOMING / OUTGOING CALLS (useful for tracing code in large codebases)
  -- ========================================================================
  vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, opts('LSP: Incoming calls'))
  vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, opts('LSP: Outgoing calls'))
end)

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
  },
  automatic_enable = false,
})





