lvim.builtin.which_key.mappings["v"] = {
  name = "+VimTex",
  v = { "<cmd>VimtexView<cr>", "View" },
  c = { "<cmd>VimtexCompile<cr>", "Compile" },
  C = { "<cmd>VimtexClean<cr>", "Clean" }
}
-- lvim.autocommands = {
--     {
--         "BufEnter", -- see `:h autocmd-events`
--         { -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
--             pattern = { "*.tex", "*.md" }, -- see `:h autocmd-events`
--             command = "PencilSoft",
--         }
--     },
-- }
