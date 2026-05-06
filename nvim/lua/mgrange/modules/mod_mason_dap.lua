return
{
  "jay-babu/mason-nvim-dap.nvim",
  --@type MasonNvimDapSettings
  opts = {
    handlers = {},
    automatic_installation = {
      exclude = {},
    },
    ensure_installed = {
      "bash",
      "codelldb",
      "python",
    },
  },
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
}
