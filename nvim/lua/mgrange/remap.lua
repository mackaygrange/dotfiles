--             _               __                              _
--            (_)             / /                             | |
--  _ ____   ___ _ __ ___    / / __ ___ _ __ ___   __ _ _ __  | |_   _  __ _
-- | '_ \ \ / / | '_ ` _ \  / / '__/ _ \ '_ ` _ \ / _` | '_ \ | | | | |/ _` |
-- | | | \ V /| | | | | | |/ /| | |  __/ | | | | | (_| | |_) || | |_| | (_| |
-- |_| |_|\_/ |_|_| |_| |_/_/ |_|  \___|_| |_| |_|\__,_| .__(_)_|\__,_|\__,_|
--                                                     | |
--                                                     |_|

-- Pull up file system with <leader>.
vim.keymap.set("n", "<leader>.", vim.cmd.Ex)

-- Allows movement of highlighted passages with <shift>j and <shift>k
vim.keymap.set("v", "J", ":m'>+1 <CR> gv=gv", {desc=""})
vim.keymap.set("v", "K", ":m'<-2 <CR> gv=gv")

-- Various keybindings for interacting with the entirety of a buffer.
vim.keymap.set("n", "<leader>ay", "ggVG\"+y")
vim.keymap.set("v", "<leader>ay", "<Esc>ggVG\"+y")

vim.keymap.set("n", "<leader>ad", "ggVGd")
vim.keymap.set("v", "<leader>ad", "<Esc>ggVGd")

-- Keeps cursor centered while navigating with jumps or searches
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allows for the delete buffer to be voided when pasting over another area of text with <leader>p. Also voids delete buffer on delete with <leader>d
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Allows you to yank to system buffer with <leader>y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Allows you to use <command>c to escape visual insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Never press <shift>q for some reason
vim.keymap.set("n", "Q", "<nop>")

-- <command>f to open new tmux session
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

-- <leader>f to format current buffer
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

-- <command>k and <command>j to navigate windows, <leader>k and <leader>j to navigate as well
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- <leader>s to replace or edit current cursor word
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Add execution permisions to current file; ex. a bash script
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Neotree Keymaps
vim.keymap.set("n", "<leader>t", ":Neotree action=show source=filesystem toggle=true reveal=true<cr>", { silent = true })

-- Remove trailing whitespace from buffer
vim.keymap.set("n", "<leader>cc", ":%s/\\s\\+$//e<CR>", { silent = true })

-- Run Current Python Script
-- Uses function callback for better control and error handling
vim.keymap.set('n', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, { noremap = true, silent = true })

vim.keymap.set('v', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, { noremap = true, silent = true })

vim.keymap.set('i', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, { noremap = true, silent = true })

-- Compile and Run C code with Makefile
-- Gets the directory name and runs make with the binary
vim.keymap.set('n', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, { noremap = true, silent = true })

vim.keymap.set('v', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, { noremap = true, silent = true })

vim.keymap.set('i', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, { noremap = true, silent = true })

local bytes_toggle = false
vim.keymap.set('n', '<leader>b', function()
  if not bytes_toggle then
    vim.cmd("%!xxd")
    bytes_toggle = true
  else
    vim.cmd("%!xxd -r")
    bytes_toggle = false
  end
end, { desc = 'View raw file in hexadecimal format', })

-- ============================================================================
-- LSP KEYBINDINGS
-- ============================================================================

-- ========================================================================
-- HOVER & DOCUMENTATION
-- ========================================================================
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover documentation', })
vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help', })
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help (insert)', })

-- ========================================================================
-- CODE NAVIGATION
-- ========================================================================
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration', })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: Go to implementation', })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP: Go to type definition', })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: List references', })

-- ========================================================================
-- DIAGNOSTICS NAVIGATION
-- ========================================================================
vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostic float', })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'LSP: Diagnostics to location list', })

-- ========================================================================
-- CODE ACTIONS & REFACTORING
-- ========================================================================
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol', })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code action', })
vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code action (visual)', })

-- ========================================================================
-- WORKSPACE & SYMBOL SEARCH
-- ========================================================================
vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = 'LSP: Document symbols', })
vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { desc = 'LSP: Workspace symbols', })
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: Add workspace folder', })
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP: Remove workspace folder', })
vim.keymap.set('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'LSP: List workspace folders', })

-- ========================================================================
-- INCOMING / OUTGOING CALLS (useful for tracing code in large codebases)
-- ========================================================================
vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, { desc = 'LSP: Incoming calls', })
vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, { desc = 'LSP: Outgoing calls', })
