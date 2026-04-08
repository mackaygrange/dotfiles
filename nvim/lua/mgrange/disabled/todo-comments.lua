return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Todo: Next comment' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Todo: Previous comment' },
    { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo: Trouble list' },
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo: Search with Telescope' },
  },
  opts = {},
}
