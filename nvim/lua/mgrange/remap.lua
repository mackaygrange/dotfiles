-- Pull up file system with <leader>.
vim.keymap.set("n", "<leader>.", vim.cmd.Ex)

-- Allows movement of highlighted passages with <shift>j and <shift>k
vim.keymap.set("v", "J", ":m'>+1 <CR> gv=gv")
vim.keymap.set("v", "K", ":m'<-2 <CR> gv=gv")

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
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- <leader>f to format current buffer
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

-- <command>k and <command>j to navigate windows, <leader>k and <leader>j to navigate as well
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- <leader>s to replace or edit current cursor word
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- create executable in bash or something
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- Neotree Keymaps
vim.keymap.set("n", "<leader>t", ":Neotree action=show source=filesystem position=left toggle=true reveal=true<cr>", {silent = true})

-- Run Current Python Script
-- Uses function callback for better control and error handling
vim.keymap.set('n', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, {noremap = true, silent = true})

vim.keymap.set('v', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, {noremap = true, silent = true})

vim.keymap.set('i', '<F9>', function()
  vim.cmd.write()
  vim.fn.system('python ' .. vim.fn.expand('%'))
end, {noremap = true, silent = true})

-- Compile and Run C code with Makefile
-- Gets the directory name and runs make with the binary
vim.keymap.set('n', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, {noremap = true, silent = true})

vim.keymap.set('v', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, {noremap = true, silent = true})

vim.keymap.set('i', '<F8>', function()
  vim.cmd.write()
  local dir_name = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
  vim.fn.system('make && ' .. dir_name)
end, {noremap = true, silent = true})

-- Quick save file
vim.keymap.set('n', '<leader>w', function() vim.cmd.write() end, {noremap = true, silent = true})
vim.keymap.set('v', '<leader>w', function() vim.cmd.write() end, {noremap = true, silent = true})

-- Quick quit
vim.keymap.set('n', '<leader>q', function() vim.cmd.quit() end, {noremap = true, silent = true})
vim.keymap.set('v', '<leader>q', function() vim.cmd.quit() end, {noremap = true, silent = true})

-- Quick savequit
vim.keymap.set('n', '<leader>wq', function() vim.cmd.wq() end, {noremap = true, silent = true})
vim.keymap.set('v', '<leader>wq', function() vim.cmd.wq() end, {noremap = true, silent = true})

-- Quick savequit all
vim.keymap.set('n', '<leader>wqa', function() vim.cmd.wqa() end, {noremap = true, silent = true})
vim.keymap.set('v', '<leader>wqa', function() vim.cmd.wqa() end, {noremap = true, silent = true})

