return {
  -- 1. Setup Conform to use specific formatters for filetypes
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        cpp = { "clang-format" },
        c = { "clang-format" },
      },
    },
  },

  -- 2. Ensure these tools are automatically installed via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "prettier",     -- JS/CSS/HTML
        "stylua",       -- Lua
        "clang-format", -- C/C++
        -- "rustfmt" is usually installed via rustup, not mason,
        -- but mason can manage it if you don't have rustup set up.
      })
    end,
  },
}
