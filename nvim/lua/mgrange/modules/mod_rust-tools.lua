return {
  'mrcjkb/rustaceanvim',
  version = '^8', -- Recommended
  ft = "rust",
  dependencies = {"mfussenegger/nvim-dap", },
  lazy = false,
  init = function()
    -- vim.g.rustaceanvim must be set BEFORE the plugin loads
    require('mgrange.config.conf_rust-tools')
  end,
}
