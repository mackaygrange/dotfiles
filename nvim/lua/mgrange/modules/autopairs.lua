return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local autopairs = require('nvim-autopairs')
    autopairs.setup({
      check_ts = true, -- Use treesitter to check for pairs
      ts_config = {
        lua = { 'string' },
        rust = { 'string', 'raw_string_literal' },
        javascript = { 'template_string' },
      },
      fast_wrap = {
        map = '<M-e>', -- Alt+e to wrap with pair
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    })

    -- Integrate with nvim-cmp (auto-add pairs after completion confirm)
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
