return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('illuminate').configure({
      -- Providers ordered by priority
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 200,
      -- Don't illuminate in these filetypes
      filetypes_denylist = {
        'neo-tree',
        'lazy',
        'mason',
        'trouble',
        'help',
      },
      -- Minimum count of matches to illuminate
      min_count_to_highlight = 2,
    })

    -- Keymaps for navigating between references
    vim.keymap.set('n', '<leader>]', function() require('illuminate').goto_next_reference(false) end,
      { desc = 'Illuminate: Next reference' })
    vim.keymap.set('n', '<leader>[', function() require('illuminate').goto_prev_reference(false) end,
      { desc = 'Illuminate: Previous reference' })
  end,
}
