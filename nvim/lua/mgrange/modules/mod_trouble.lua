return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'Trouble' },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: Diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Trouble: Buffer diagnostics' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Trouble: Symbols' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Trouble: Location list' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Trouble: Quickfix list' },
  },
  opts = {},
}
