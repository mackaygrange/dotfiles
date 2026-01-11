-- ============================================================================
-- NEOVIM OPTIONS CONFIGURATION
-- ============================================================================
-- This file configures all Neovim options for editor behavior, appearance,
-- and functionality. Each option is documented with its purpose.

-- ============================================================================
-- LINE NUMBERING
-- ============================================================================
vim.opt.nu = true                   -- Enable absolute line numbers
vim.opt.number = true               -- Same as 'nu', enables line numbers
vim.opt.relativenumber = true       -- Show relative line numbers (useful for jumps and commands)
vim.opt.startofline = false         -- When moving lines, keep cursor in same column instead of going to start

-- ============================================================================
-- VISUAL FEEDBACK & DISPLAY
-- ============================================================================
vim.opt.showmode = false            -- Don't show mode (INSERT, VISUAL, etc.) in status line
vim.opt.showmatch = true            -- Briefly jump to matching bracket when inserted
vim.opt.scrolloff = 8               -- Minimum lines to keep above/below cursor when scrolling
vim.opt.virtualedit = "block"       -- Allow cursor to move to non-existent places in block selection mode
vim.opt.signcolumn = "yes"          -- Always show sign column (for diagnostics, breakpoints, etc.)
vim.opt.winborder = "rounded"       -- Use rounded borders for split windows
vim.opt.termguicolors = true        -- Enable 24-bit RGB colors in terminal

-- ============================================================================
-- LIST CHARACTERS & LINE WRAPPING
-- ============================================================================
vim.opt.list = true                 -- Display invisible characters
vim.opt.listchars = "tab:⋮ ,extends:❯,precedes:❮,nbsp:␣"  -- Define what invisible chars look like
vim.opt.linebreak = true            -- Break lines at word boundaries, not mid-word
vim.opt.showbreak = "↪"             -- Character shown when line is wrapped
vim.opt.wrap = true                 -- Enable visual line wrapping
vim.opt.textwidth = 120             -- Hard wrap text at 120 characters
vim.opt.colorcolumn = "+1"          -- Show visual guide at textwidth + 1

-- ============================================================================
-- INDENTATION & TABS
-- ============================================================================
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.tabstop = 4                 -- How many spaces a tab character represents (display)
vim.opt.softtabstop = 2             -- How many spaces soft tabs (insert) represent
vim.opt.shiftwidth = 2              -- Number of spaces for auto-indent and shift operations
vim.opt.shiftround = true           -- Round indent to multiple of shiftwidth
vim.opt.breakindent = true          -- Preserve indentation when wrapping lines
vim.opt.smartindent = true          -- Intelligently auto-indent based on code syntax

-- ============================================================================
-- FILE HANDLING & PERSISTENCE
-- ============================================================================
vim.opt.autoread = true             -- Auto-reload files changed outside of Neovim
vim.opt.swapfile = false            -- Don't create swap files
vim.opt.backup = false              -- Don't create backup files
vim.opt.undofile = true             -- Enable persistent undo
vim.opt.undolevels = 10000          -- Number of undo steps to remember
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")  -- Directory for undo files
vim.opt.hidden = true               -- Allow switching buffers without saving

-- ============================================================================
-- SPELL CHECKING
-- ============================================================================
vim.opt.spelllang = "en_us"         -- Language for spell checking
vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/dictionary.utf-8.add")  -- Custom dictionary

-- ============================================================================
-- SPLIT BEHAVIOR
-- ============================================================================
vim.opt.splitbelow = true           -- New horizontal splits appear below current window
vim.opt.splitright = true           -- New vertical splits appear to the right of current window

-- ============================================================================
-- SEARCH BEHAVIOR
-- ============================================================================
vim.opt.ignorecase = true           -- Case-insensitive search by default
vim.opt.smartcase = true            -- Case-sensitive if search contains uppercase letters
vim.opt.wrapscan = true             -- Search wraps around end of file
vim.opt.hlsearch = false            -- Don't highlight all search matches (can toggle with vim.opt.hlsearch)
vim.opt.incsearch = true            -- Show matches while typing search pattern

-- ============================================================================
-- PERFORMANCE & TIMING
-- ============================================================================
vim.opt.timeoutlen = 500            -- Time (ms) to wait for mapped sequence to complete
vim.opt.updatetime = 50             -- Time (ms) for swap file to be written and CursorHold event

-- ============================================================================
-- FILENAME HANDLING
-- ============================================================================
vim.opt.isfname:append("@-@")       -- Treat '@' as part of filename for navigation

-- ============================================================================
-- COMPLETION OPTIONS
-- ============================================================================
-- For Neovim < 0.11.0: use 'noinsert' or 'noselect' for chat autocompletion
-- 'popup' provides best autocompletion experience with CopilotChat
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- ============================================================================
-- MISCELLANEOUS
-- ============================================================================
vim.opt.grepformat = "%f%l%c%m"     -- Format for grep output parsing

-- ============================================================================
-- LEADER KEY
-- ============================================================================
vim.g.mapleader = " "               -- Set space as leader key


