return
{
  "mfussenegger/nvim-dap",
  keys = { "<leader>d" },
  dependencies = { "rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim" },
  config = function()
    require("dapui").setup()
    -- DAP configurations
  end,
}

