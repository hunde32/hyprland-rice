return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>", -- Use Tab to accept AI suggestions
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { cpp = true }, -- Example: disable in cpp if you want
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      disable_inline_completion = false, -- ensures native completion doesn't conflict
      disable_keymaps = false
    })
  end,
}
