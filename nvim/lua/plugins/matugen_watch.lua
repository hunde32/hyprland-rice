return {
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      -- Define the file to watch
      local color_file = vim.fn.expand("~/.config/nvim/lua/matugen_colors.lua")

      -- Function to reload colors
      local function reload_colors()
        -- clear the cache so the new file is read
        package.loaded["matugen_colors"] = nil
        -- re-require the theme setup to apply changes
        require("tokyonight").setup(opts)
        vim.cmd("colorscheme tokyonight")
      end

      -- Set up a file system watcher
      local w = vim.uv.new_fs_event()
      w:start(color_file, {}, vim.schedule_wrap(function()
        reload_colors()
      end))

      return opts
    end,
  }
}
