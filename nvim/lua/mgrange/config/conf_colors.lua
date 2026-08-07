require("rose-pine").setup({
  variant = "moon",     -- auto, main, moon, or dawn
  dark_variant = "moon", -- main, moon, or dawn
  dim_inactive_windows = true,
  extend_background_behind_borders = false,

  enable = {
    terminal = true,
    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
    migrations = true,      -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },

  palette = {
    moon = {
      base = '#262335',
      surface = '#2e2a3e',
      overlay = '#3b3654',
      muted = '#6c6783',
      subtle = '#848bbd',
      text = '#e0d9f5',
      love = '#fe4450',
      gold = '#fede5d',
      rose = '#ff7edb',
      pine = '#36f9f6',
      foam = '#72f1b8',
      iris = '#b893ce',
      highlight_low = '#2e2a3e',
      highlight_med = '#3f3a56',
      highlight_high = '#504a6e',
    },
  },

  -- NOTE: Highlight groups are extended (merged) by default. Disable this
  -- per group via `inherit = false`
  highlight_groups = {
    -- Telescope-style floating window borders: panel background with muted border
    NormalFloat = { bg = "none" },
    FloatBorder = { fg = "muted", bg = "none" },
    FloatTitle = { fg = "foam", bg = "none", bold = true },
  },

  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
})

function SetColors(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)


  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
end

SetColors()
