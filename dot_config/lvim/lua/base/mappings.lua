lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>" -- save with C-s



lvim.keys.normal_mode["<C-n>"] = "<cmd>BufSurfForward<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>BufSurfBack<cr>"

lvim.keys.normal_mode["<C-e>"] = "<cmd>NvimTreeFocus<cr>"


lvim.builtin.terminal.open_mapping = "<C-t>"

-- Telescopeconfigs
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-d>"] = actions.preview_scrolling_down,
    ["<C-u>"] = actions.preview_scrolling_up,
  },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Telescope",
  b = { "<cmd>Telescope buffers<cr>", "Telescope buffers" },
  f = { "<cmd>Telescope find_files<cr>", "Telescope find files" },
  p = { "<cmd>Telescope projects<cr>", "Telescope find projects" },
  r = { "<cmd>Telescope oldfiles<cr>", "Telescope find recents" },
  g = { "<cmd>Telescope live_grep<cr>", "Telescope live_grep" },
}

-- Replace vim search with telescope fuzzy fing
lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" }


-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

lvim.builtin.which_key.mappings["m"] = {
  name = "+Harpoon",
  f = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark the file" },
  n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Move to next mark" },
  p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Move to previous mark" },
  t = { "<cmd>Telescope harpoon marks<cr>", "Show marks" },
  ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Navigate to file 1" },
  ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Navigate to file 2" },
  ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Navigate to file 3" },
  ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Navigate to file 4" }
}
