return {
  'mrcjkb/rustaceanvim',
  version = '^8', -- Recommended
  lazy = false,
  init = function()
    -- vim.g.rustaceanvim must be set BEFORE the plugin loads
    require('mgrange.config.rust-tools')
  end,
}
