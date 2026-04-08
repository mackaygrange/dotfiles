return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 300,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation between hunks
      map('n', ']h', gs.next_hunk, { desc = 'Git: Next hunk' })
      map('n', '[h', gs.prev_hunk, { desc = 'Git: Previous hunk' })

      -- Stage / reset hunks
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git: Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: Reset hunk' })
      map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'Git: Stage hunk (visual)' })
      map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = 'Git: Reset hunk (visual)' })

      -- Stage / reset buffer
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git: Stage buffer' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git: Reset buffer' })

      -- Undo stage
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git: Undo stage hunk' })

      -- Preview & blame
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: Preview hunk' })
      map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Git: Blame line (full)' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Git: Diff this' })
      map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Git: Diff against ~' })

      -- Toggle blame
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Git: Toggle line blame' })
    end,
  },
}
