return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      {
        "<leader>mt1",
        function()
          require("harpoon.term").gotoTerminal(1)
        end,
        desc = "Go to terminal 1",
      },

      {
        "<leader>mn",
        function()
          require("harpoon.ui").nav_next()
        end,
        desc = "Previous mark",
      },
      {
        "<leader>mp",
        function()
          require("harpoon.ui").nav_prev()
        end,
        desc = "Next mark",
      },
      {
        "<leader>ma",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark current file",
      },

      {
        "<leader>ml",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Show quick menu",
      },

      {
        "<leader>m1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Go to mark 1",
      },

      {
        "<leader>m2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Go to mark 2",
      },
      {
        "<leader>m3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Go to mark 3",
      },
      {
        "<leader>m4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Go to mark 4",
      },

      {
        "<leader>m5",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        desc = "Go to mark 5",
      },
      {
        "<leader>m6",
        function()
          require("harpoon.ui").nav_file(6)
        end,
        desc = "Go to mark 6",
      },
    },
  },
}
