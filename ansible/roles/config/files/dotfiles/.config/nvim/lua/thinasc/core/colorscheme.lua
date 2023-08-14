local status, tokyonight = pcall(require, "tokyonight")
if not status then
  return
end

tokyonight.setup({
  style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    --   -- Style to be applied to different syntax groups
    --   -- Value is any valid attr-list value for `:help nvim_set_hl`
    -- comments = "italic",
    --   keywords = { italic = true },
    functions = { bold = true },
    --   variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
})

vim.cmd([[colorscheme tokyonight]])
