return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
   _   _  __     __  ___   __  __
  | \ | | \ \   / / |_ _| |  \/  |
  |  \| |  \ \ / /   | |  | |\/| |
  | |\  |   \ V /    | |  | |  | |
  |_| \_|    \_/    |___| |_|  |_|
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- These are the 3 buttons you requested
          center = {
            {
              action = "Telescope find_files cwd=~/Documents/Projects",
              desc = " Projects",
              icon = " ",
              key = "p",
            },
            {
              action = "Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = "qa",
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      return opts
    end,
  },
}
