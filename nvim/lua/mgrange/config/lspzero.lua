-- ============================================================================
-- LSP ZERO CONFIGURATION
-- ============================================================================
-- This file sets up language server protocol (LSP) integration with Mason
-- for package management and automatic installation of LSP servers.

local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

-- ============================================================================
-- DIAGNOSTIC SIGNS & APPEARANCE
-- ============================================================================
-- Customize diagnostic signs shown in the sign column
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚡' })
sign({ name = 'DiagnosticSignInfo', text = 'ℹ' })

-- Configure diagnostic display options
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
  },
})

-- ============================================================================
-- LSP KEYBINDINGS & ATTACH
-- ============================================================================
-- This runs when an LSP server attaches to a buffer
lsp_zero.on_attach(function(client, bufnr)
  -- Use lsp-zero's default keybindings for the current buffer
  -- These include: gd (goto definition), gr (goto references), etc.
  lsp_zero.default_keymaps({buffer = bufnr})

  -- Additional helpful keybindings
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end)

-- ============================================================================
-- MASON SETUP (Package Manager for LSP Servers)
-- ============================================================================
-- Mason automatically installs and manages LSP servers, formatters, and linters
require('mason').setup({})

-- ============================================================================
-- MASON-LSPCONFIG SETUP
-- ============================================================================
-- Bridges Mason with lspconfig to auto-install servers and wire up their configs
require('mason-lspconfig').setup({
  -- Servers to automatically install
  ensure_installed = {
    "spellcheck",           -- Spell checking
    "code-spell",           -- Code spell checker
    "shfmt",                -- Shell script formatter
    "stylua",               -- Lua formatter
    "pyright",              -- Python language server
    "lua-language-server",  -- Lua language server
    "vtsls"                 -- TypeScript/JavaScript language server
  },
  
  -- Custom handlers for each server
  handlers = {
    -- Default handler: setup all servers with default config
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    
    -- Lua LS custom setup with enhanced settings
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }  -- Recognize 'vim' global
            }
          }
        }
      })
    end,

    -- Pyright configuration
    pyright = function()
      require('lspconfig').pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              extraPaths = {},
            }
          }
        }
      })
    end,

    -- TypeScript/JavaScript setup
    vtsls = function()
      require('lspconfig').vtsls.setup({
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            }
          }
        }
      })
    end,
  }
})



