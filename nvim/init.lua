--             _               ___       _ _     _
--            (_)             / (_)     (_) |   | |
--  _ ____   ___ _ __ ___    / / _ _ __  _| |_  | |_   _  __ _
-- | '_ \ \ / / | '_ ` _ \  / / | | '_ \| | __| | | | | |/ _` |
-- | | | \ V /| | | | | | |/ /  | | | | | | |_ _| | |_| | (_| |
-- |_| |_|\_/ |_|_| |_| |_/_/   |_|_| |_|_|\__(_)_|\__,_|\__,_|

require("mgrange")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Custom setup copied from LazyVim starter
-- https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
require("lazy").setup({
  defaults = {
    version = false,
  },
  spec = {
    { import = "mgrange.modules" },
  },
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
      },
    },
  },
})

require("mgrange.config")
