return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      enabled = true,
      default_prompt = '> ',
      border = 'rounded',
      relative = 'cursor',
    },
    select = {
      enabled = true,
      -- Use telescope as the default selector for vim.ui.select
      backend = { 'telescope', 'builtin' },
    },
  },
}
