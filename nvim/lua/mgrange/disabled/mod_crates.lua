return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local crates = require('crates')
    crates.setup({
      popup = {
        border = 'rounded',
      },
    })

    -- Keymaps for Cargo.toml
    vim.api.nvim_create_autocmd('BufRead', {
      pattern = 'Cargo.toml',
      callback = function(ev)
        local opts = function(desc)
          return { buffer = ev.buf, silent = true, desc = desc }
        end

        vim.keymap.set('n', '<leader>ct', crates.toggle, opts('Crates: Toggle'))
        vim.keymap.set('n', '<leader>cr', crates.reload, opts('Crates: Reload'))
        vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts('Crates: Show versions'))
        vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts('Crates: Show features'))
        vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts('Crates: Show dependencies'))
        vim.keymap.set('n', '<leader>cu', crates.update_crate, opts('Crates: Update crate'))
        vim.keymap.set('v', '<leader>cu', crates.update_crates, opts('Crates: Update selected crates'))
        vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts('Crates: Upgrade crate'))
        vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts('Crates: Upgrade selected crates'))
      end,
    })
  end,
}
