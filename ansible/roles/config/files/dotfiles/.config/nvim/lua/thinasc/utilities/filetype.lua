local M = {}

function M.setup()
  local filetype = require("filetype")

  filetype.setup({
    overrides = {
      extensions = {
        nix = "nix",
      },
      literal = {
        [".stylelintrc"] = "json",
        [".env"] = "sh",
        [".envrc"] = "sh",
        ["resolv.conf"] = "conf",
        ["tsconfig.json"] = "jsonc",
      },
      complex = {
        ["tsconfig.*"] = "jsonc",
      },
    },
  })
end

return M
