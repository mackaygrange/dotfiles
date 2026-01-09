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

require("mgrange")
require("lazy").setup("mgrange.modules")
require("mgrange.config")

local spec = {
  { import = "plugins" },
}

-- Custom setup copied from LazyVim starter
-- https://github.com/LazyVim/starter/blob/main/lua/config/lazy.lua
require("lazy").setup({
  defaults = {
    version = false,
  },
  spec = spec,
  ui = {
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
  performance = {
    rtp = {
      disabled_plugins = {
      },
    },
  },
})
