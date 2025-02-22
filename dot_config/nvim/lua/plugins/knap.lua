return {
  {
    "frabjous/knap",
    config = function()
      local gknapsettings = {
        mdtohtml = "pandoc --filter pandoc-kroki --lua-filter $ZK_NOTEBOOK_DIR/support/backlinks.lua --defaults=$ZK_NOTEBOOK_DIR/support/pandoc.yaml $ZK_NOTEBOOK_DIR/support/metadata.yaml %srcfile% -o $ZK_NOTEBOOK_DIR/export/%outputfile%",
        mdtohtmlviewerlaunch = "falkon $ZK_NOTEBOOK_DIR/export/%outputfile%",
        delay = 100,
      }
      vim.g.knap_settings = gknapsettings
    end,

    keys = {
      {
        "<leader>kp",
        function()
          require("knap").process_once()
        end,
        desc = "processes the document once, and refreshes the view",
      },

      {
        "<leader>kc",
        function()
          require("knap").close_viewer()
        end,
        desc = "closes the viewer application, and allows settings to be reset",
      },
      {
        "<leader>kt",
        function()
          require("knap").toggle_autopreviewing()
        end,
        desc = "toggles the auto-processing on and off",
      },

      {
        "<leader>kf",
        function()
          require("knap").forward_jump()
        end,
        desc = "invokes a SyncTeX forward search, or similar, where appropriate",
      },
    },
  },
}
