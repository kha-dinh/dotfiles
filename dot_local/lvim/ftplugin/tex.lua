local opts = {
  texlab = {
    forwardSearch = {
      executable = "zathura"
    }
  }
}
require("lvim.lsp.manager").setup("texlab", opts)
