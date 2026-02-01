return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = true, -- Enable transparency
      style = "storm",    -- Options: storm, night, moon, day
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        -- Try to load matugen colors safely
        local status, matugen = pcall(require, "matugen_colors")
        if status then
          -- Override TokyoNight base colors with Matugen
          colors.bg = "NONE" -- Ensure main background is nil for transparency
          colors.fg = matugen.foreground
          colors.blue = matugen.primary
          colors.cyan = matugen.secondary
          colors.magenta = matugen.tertiary
          colors.red = matugen.error

          -- You can map more specific UI elements here if you wish
          colors.border = matugen.outline
        end
      end,
    },
  },
}
