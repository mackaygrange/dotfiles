local builtin = require('telescope.builtin')

local function live_grep_git_files()
  -- Get tracked git files as a table
  local stdout = vim.fn.systemlist("git ls-files")

  -- Verify if the command ran successfully inside a git repository
  if vim.v.shell_error ~= 0 then
    print("Not a git repository, falling back to standard live_grep")
    builtin.live_grep()
    return
  end

  -- Pass the tracked files into the search_dirs option
  builtin.live_grep({
    search_dirs = stdout,
  })
end

vim.keymap.set('n', '<leader>af', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>as', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps', live_grep_git_files, {})
-- vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({search = vim.fn.input("grep > ")})end)

