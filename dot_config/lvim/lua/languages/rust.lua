vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust-analyzer"})


local opts          = {
  tools = {
    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "<-",
      other_hints_prefix = "=>",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },
      auto_focus = true,
    },
  },
  server = {
    on_init = require("lvim.lsp").common_on_init,
    on_attach = function(client, bufnr)
      require("lvim.lsp").common_on_attach(client, bufnr)
      -- local rt = require "rust-tools"
      -- -- Hover actions
      -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- -- Code action groups
      -- vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        -- HACK: https://github.com/simrat39/rust-tools.nvim/issues/300
        inlayHints = { locationLinks = false },
        rustc = { source = "discover" },
      }

    }
  },
}
local path          = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
local codelldb_path = path .. "adapter/codelldb"
local liblldb_path  = path .. "lldb/lib/liblldb.so"

if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
  opts.dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  }
else
  local msg = "Either codelldb or liblldb is not readable."
      .. "\n codelldb: "
      .. codelldb_path
      .. "\n liblldb: "
      .. liblldb_path
  vim.notify(msg, vim.log.levels.ERROR)
end


require("rust-tools").setup(opts)

lvim.builtin.which_key.mappings["ds"] = {
  "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustDebuggables]] else require'dap'.continue() end<CR>",
  "Start",
}
