return
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "javascript", "c", "cpp", "cmake", "python", "lua", "vim", "vimdoc", "query", "rust", "bash", "toml", "linkerscript", "make" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
  }
}

