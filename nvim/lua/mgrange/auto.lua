local my_group = vim.api.nvim_create_augroup("MG", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.textwidth = 120
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Format Rust files on save",
  group = my_group,
  pattern = { "*.rs" },
  callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Jump to first non-comment, non-empty line on file open",
  group= my_group,
  callback = function()
    -- Only run if no line was specified (e.g. from the command line: nvim file.c +10)
    if vim.fn.line(".") > 1 then return end

    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype
    local total_lines = vim.api.nvim_buf_line_count(bufnr)

    -- Map filetypes to their comment patterns (Lua patterns)
    local comment_patterns = {
      c          = "^%s*//",
      cpp        = "^%s*//",
      java       = "^%s*//",
      javascript = "^%s*//",
      typescript = "^%s*//",
      go         = "^%s*//",
      rust       = "^%s*//",
      swift      = "^%s*//",
      kotlin     = "^%s*//",
      python     = "^%s*#",
      sh         = "^%s*#",
      bash       = "^%s*#",
      zsh        = "^%s*#",
      ruby       = "^%s*#",
      perl       = "^%s*#",
      lua        = "^%s*%-%-",
      vim        = "^%s*\"",
      vimscript  = "^%s*\"",
      haskell    = "^%s*%-%-",
      sql        = "^%s*%-%-",
      css        = "^%s*/%*",
      html       = "^%s*<!%-%-",
      -- Fallback: treat lines starting with common comment chars as comments
    }

    -- Also handle block comment openers generically
    local block_comment_patterns = {
      "^%s*/%*",   -- /* (C-style block comments)
      "^%s*%*",    -- * (inside C-style block comments)
      "^%s*<!%-%-", -- <!-- (HTML)
    }

    local line_pattern = comment_patterns[ft]

    for i = 0, total_lines - 1 do
      local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
      if line then
        local is_empty = line:match("^%s*$")
        local is_line_comment = line_pattern and line:match(line_pattern)
        local is_block_comment = false
        for _, pat in ipairs(block_comment_patterns) do
          if line:match(pat) then
            is_block_comment = true
            break
          end
        end

        if not is_empty and not is_line_comment and not is_block_comment then
          vim.api.nvim_win_set_cursor(0, { i + 1, 0 })
          vim.cmd("normal! zt")
          break
        end
      end
    end
  end,
})


