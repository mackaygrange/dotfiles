return {
  -- Mason: Package manager for LSP servers, formatters, linters
  'williamboman/mason.nvim',
  
  -- Mason LSPConfig: Bridge between Mason and lspconfig
  'williamboman/mason-lspconfig.nvim',
  
  -- LSP Zero: Opinionated LSP setup with sensible defaults
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  
  -- LSPConfig: Configs for various language servers
  'neovim/nvim-lspconfig',
  
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
}

