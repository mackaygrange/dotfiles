-- SETUP FOR LSPZERO HERE
local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

-- lsp_config.clangd.setup({})
-- lsp_config.lua_ls.setup({})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup(
{
  ensure_installed = {},
  handlers =
  {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
    end,
  }
})

