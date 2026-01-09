vim.opt.nu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.showmatch = true
vim.opt.startofline = false
vim.opt.scrolloff = 15
vim.opt.virtualedit = "block"
vim.opt.autoread = true
vim.opt.timeoutlen = 500
vim.opt.grepformat = "%f%l%c%m"
vim.opt.winborder = "rounded"

vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.breakindent = true
vim.smartindent = true

vim.opt.wrap = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.opt.undolevels = 10000
vim.opt.undofile = true
vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/dictionary.utf-8.add")
vim.opt.spelllang = "en_us"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.listchars = "tab:⋮ ,extends:❯,precedes:❮,nbsp:␣"
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.signcolumn = "yes"

vim.opt.list = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.wrapscan = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

