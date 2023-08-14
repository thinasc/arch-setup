local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local encoding = {
  "o:encoding",
  fmt = string.upper,
}

local filename = {
  "filename",
  path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local lsp = {
  function(msg)
    msg = msg or "  LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "  LS Inactive"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- Add Client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end
    end

    local unique_client_names = vim.fn.uniq(buf_client_names)

    local language_servers = "  [" .. table.concat(unique_client_names, ", ") .. "]"

    return language_servers
  end,
  color = { gui = "bold" },
}

lualine.setup({
  options = {
    theme = "tokyonight",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    icons_enabled = true,
    disabled_filetypes = {
      "diff",
      "DiffviewFiles",
      "NeogitLogView",
      "NeogitPopup",
      "NeogitStatus",
      "NvimTree",
      "Outline",
      "undotree",
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { filename },
    lualine_x = {
      lsp,
      encoding,
      "fileformat",
      "filetype",
    },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
