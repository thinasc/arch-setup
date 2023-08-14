local api = vim.api
local g = vim.g
local opt = vim.opt

local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

autocmd("TextYankPost", {
  group = augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8" -- The Encoding written to a File
opt.fileformat = "unix"

-- General
opt.shell = "fish" -- Default Shell
opt.mouse = "a" -- Mouse Support
opt.updatetime = 50 -- Faster Completion (default is 4000 ms = 4 s)
opt.swapfile = false -- Creates a Swapfile
opt.timeoutlen = 100 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- Enable persistent undo
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.completeopt = { "menuone", "noinsert", "noselect" } -- Mostly just for cmp
opt.laststatus = 2
opt.clipboard:append({ "unnamedplus" }) -- Allows Neovim to access the system clipboard
opt.backspace = "indent,eol,start"

-- Remove Builtin Plugins
g.loaded = 1 -- Recommended settings from nvim-tree documentation
g.loaded_netrw = 1 -- Recommended settings from nvim-tree documentation
g.loaded_netrwPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_zip = 1
g.did_load_filetypes = 1 -- Do not source the default filetype.vim

-- Backup
opt.backup = false -- Creates a Backup File
opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Search
opt.hlsearch = false -- Highlight all matches on previous search pattern
opt.ignorecase = true -- Case Insensitive searching UNLESS /C or capital in search
opt.path:append({ "**" }) -- Finding Files - Search Down into Subfolders
opt.wildignorecase = true
opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*", "__pycache__" })
opt.wildignore:append({ ".git/*", "*/node_modules/*" })

-- Command Line
opt.showcmd = false
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.cmdheight = 1 -- Give more space for displaying messages.

-- UI
opt.termguicolors = true
opt.cursorline = true -- Highlight the Current Line
opt.background = "dark"
opt.splitbelow = true -- Force all horizontal splits to go below current window
opt.splitright = true -- Force all vertical splits to go to the right of current window
opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- Minimal number of screen lines to keep left and right of the cursor.
opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
opt.pumheight = 10 -- Pop Up Menu Height
opt.numberwidth = 4 -- set number column width to 2 {default 4}

-- Editor
opt.number = true -- Set Numbered Lines
opt.relativenumber = true -- Set Relative Numbered Lines
opt.tabstop = 2 -- Insert 2 spaces for a tab
opt.shiftwidth = 2 -- The number of spaces inserted for each indentation
opt.autoindent = true
opt.breakindent = true
opt.expandtab = true -- Convert Tabs to Spaces
opt.smarttab = true
opt.smartcase = true -- Smart Case
opt.smartindent = true -- Make indenting smarter again
opt.wrap = false -- No Wrap Lines
opt.conceallevel = 0 -- So that `` is visible in markdown files

opt.shortmess:append("c")
opt.iskeyword:append("-")

g.editor_config_enable = true
-- Providers
g.loaded_perl_provider = 0
-- TODO: Find a way to use this command
-- g.python_host_prog     = "/home/vagrant/projects/timearc-ccms-backend/.env_python3.8/bin/python"
-- g.python3_host_prog    = "/home/vagrant/projects/timearc-ccms-backend/.env_python3.8/bin/python3"
-- which -a python3 | head -n1
-- vim.fn.trim(vim.fn.system "which -a python | head -n1")
