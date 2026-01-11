-- ============================================================================
-- COMPLETION & SNIPPET CONFIGURATION
-- ============================================================================
-- This file configures nvim-cmp for autocompletion and integrates with
-- LuaSnip for snippet expansion, and is compatible with CopilotChat.nvim.
--
-- Note: completeopt is configured in set.lua as:
--   vim.opt.completeopt = { "menuone", "noselect", "popup" }
-- This includes "noselect" for chat autocompletion and "popup" for best UX.

local cmp = require('cmp')
local luasnip = require('luasnip')
local lsp_zero = require('lsp-zero')

-- ============================================================================
-- LUASNIP SETUP
-- ============================================================================
-- Configure LuaSnip for snippet expansion
luasnip.config.setup({})

-- ============================================================================
-- NVIM-CMP SETUP
-- ============================================================================
cmp.setup({
  -- ========================================================================
  -- SNIPPET ENGINE
  -- ========================================================================
  snippet = {
    expand = function(args)
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- ========================================================================
  -- COMPLETION SOURCES (ordered by priority)
  -- ========================================================================
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },        -- LSP completions (highest priority)
    { name = 'luasnip' },         -- Snippet completions
    { name = 'buffer' },          -- Buffer text completions
    { name = 'path' },            -- File path completions
  }),

  -- ========================================================================
  -- KEYMAP CONFIGURATION
  -- ========================================================================
  mapping = cmp.mapping.preset.insert({
    -- Previous item in completion menu
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select_opts),

    -- Next item in completion menu
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select_opts),

    -- Accept the current selection
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- Abort the completion menu
    ['<C-e>'] = cmp.mapping.abort(),

    -- Manually trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Snippet jumping (forward/backward)
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),

    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  }),

  -- ========================================================================
  -- COMPLETION MENU FORMATTING
  -- ========================================================================
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      -- Set custom icons for different completion kinds
      local kind_icons = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      vim_item.kind = (kind_icons[vim_item.kind] or '') .. vim_item.kind

      -- Show source name in menu
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snippet]',
        buffer = '[Buffer]',
        path = '[Path]',
      })[entry.source.name]

      return vim_item
    end,
  },

  -- ========================================================================
  -- COMPLETION MENU APPEARANCE
  -- ========================================================================
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- ============================================================================
-- SEARCH COMPLETION (in "/" and "?")
-- ============================================================================
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- ============================================================================
-- COMMAND COMPLETION (in ":")
-- ============================================================================
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})

-- ============================================================================
-- COMPLETION BEHAVIOR OPTIONS
-- ============================================================================
-- Preset completion selection options for consistency
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
