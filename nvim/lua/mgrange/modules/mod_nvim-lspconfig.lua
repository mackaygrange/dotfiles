return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason: Package manager for LSP servers, formatters, linters
    'williamboman/mason.nvim',

    -- Mason LSPConfig: Bridge between Mason and lspconfig
    'williamboman/mason-lspconfig.nvim',

    -- =====================================================================
    -- COMPLETION PLUGINS
    -- =====================================================================

    -- nvim-cmp: Completion engine
    'hrsh7th/nvim-cmp',

    -- LSP completion source
    'hrsh7th/cmp-nvim-lsp',

    -- Buffer completion source
    'hrsh7th/cmp-buffer',

    -- Path completion source
    'hrsh7th/cmp-path',

    -- Command line completion source
    'hrsh7th/cmp-cmdline',

    -- =====================================================================
    -- SNIPPET PLUGINS
    -- =====================================================================

    -- LuaSnip: Snippet engine
    'L3MON4D3/LuaSnip',

    -- Snippet completions
    'saadparwaiz1/cmp_luasnip',
  },
}

