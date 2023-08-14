local status, telescope = pcall(require, "telescope")
if not status then
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local config = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    layout_config = {
      prompt_position = "top",
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    vimgrep_arguments = vimgrep_arguments,
    prompt_prefix = " ",
    selection_caret = " ",
    initial_mode = "insert",
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    file_ignore_patterns = {},
    path_display = { "smart" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
})

telescope.load_extension("fzf")

local M = {}

M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end
