return
{
  "mfussenegger/nvim-dap",
  keys = { "<leader>d" },
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", },
  config = function()
    require("dapui").setup()

    --== Keybindngs ==--
    vim.keymap.set('n', '<leader>db', function() require("dapui").toggle() end, { desc = 'DAP: Toggle DAP-UI', })

    --== Adapter Config ==--


  end,
}
