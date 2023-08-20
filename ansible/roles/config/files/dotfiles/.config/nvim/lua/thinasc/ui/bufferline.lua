local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

bufferline.setup({
  options = {
    tab_size = 21,
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    -- close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    -- right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    -- left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    -- middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    color_icons = true,
    separator_style = { "", "" },
    -- left_trunc_marker = "",
    -- right_trunc_marker = "",
    -- modified_icon = "●",
    -- buffer_close_icon = "",
    -- show_buffer_icons = true,
    -- show_buffer_close_icons = true,
    -- show_tab_indicators = true,
    -- persist_buffer_sort = true,
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon", -- can also be 'underline'|'none',
    },
    show_tab_indicators = true,
    show_close_icon = false,
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- always_show_bufferline = true,
    offsets = {
      {
        filetype = "DiffviewFiles",
        text = "Diffview Files",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "lazy",
        text = "Lazy",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
  },
})
