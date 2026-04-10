vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
    -- Display hover actions in a bordered float window
    float_win_config = {
      border = 'rounded',
    },
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      local opts = function(desc)
        return { buffer = bufnr, noremap = true, silent = true, desc = desc }
      end

      -- ====================================================================
      -- RUST-SPECIFIC CODE NAVIGATION & ACTIONS
      -- ====================================================================
      -- Expand macro recursively (see what macros generate)
      vim.keymap.set('n', '<leader>rm', function()
        vim.cmd.RustLsp('expandMacro')
      end, opts('Rust: Expand macro'))

      -- Open parent module
      vim.keymap.set('n', '<leader>rp', function()
        vim.cmd.RustLsp('parentModule')
      end, opts('Rust: Parent module'))

      -- Open cargo.toml for the current crate
      vim.keymap.set('n', '<leader>rc', function()
        vim.cmd.RustLsp('openCargo')
      end, opts('Rust: Open Cargo.toml'))

      -- Join lines (smart join for Rust)
      vim.keymap.set('n', '<leader>rj', function()
        vim.cmd.RustLsp('joinLines')
      end, opts('Rust: Join lines'))

      -- Hover actions (enhanced hover with Rust-specific actions)
      vim.keymap.set('n', '<leader>rh', function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
      end, opts('Rust: Hover actions'))

      -- Explain error under cursor
      vim.keymap.set('n', '<leader>re', function()
        vim.cmd.RustLsp('explainError')
      end, opts('Rust: Explain error'))

      -- Render diagnostics (show full compiler output)
      vim.keymap.set('n', '<leader>rd', function()
        vim.cmd.RustLsp('renderDiagnostic')
      end, opts('Rust: Render diagnostic'))

      -- Run / Debug runnables
      vim.keymap.set('n', '<leader>rr', function()
        vim.cmd.RustLsp('runnables')
      end, opts('Rust: Runnables'))

      vim.keymap.set('n', '<leader>rb', function()
        vim.cmd.RustLsp('debuggables')
      end, opts('Rust: Debuggables'))
    end,

    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        -- Useful for embedded development: check on save with clippy
        checkOnSave = true,
        check = {
          command = 'clippy',
          extraArgs = { '--no-deps' },
        },
        -- Cargo settings
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
        },
        -- Proc macro support (important for embedded macros like #[entry])
        procMacro = {
          enable = true,
        },
        -- Inlay hints for better code readability
        inlayHints = {
          bindingModeHints = { enable = true },
          closureReturnTypeHints = { enable = 'always' },
          lifetimeElisionHints = { enable = 'always' },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
