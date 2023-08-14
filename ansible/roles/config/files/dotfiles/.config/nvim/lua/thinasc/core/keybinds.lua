-- Set Leader Key
vim.g.mapleader = " "

local nnoremap = require("thinasc.core.keymap").nnoremap
local inoremap = require("thinasc.core.keymap").inoremap
local vnoremap = require("thinasc.core.keymap").vnoremap
local xnoremap = require("thinasc.core.keymap").xnoremap

-- Normal --
nnoremap("<C-a>", "gg<S-v>G") -- Select All
nnoremap("dw", 'vb"_d') -- Delete a Word Backwards
nnoremap(
  "<C-f>",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy{ previewer = false } )<cr>"
)

-- Better Window Navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Improve Navigation with Page Up and Page Down
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")

-- Improve Navigation into Search
nnoremap("*", "*zzzv")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Resize With Arrows
nnoremap("<C-Up>", "<cmd>resize -2<cr>")
nnoremap("<C-Down>", "<cmd>resize +2<cr>")
nnoremap("<C-Left>", "<cmd>vertical resize -2<cr>")
nnoremap("<C-Right>", "<cmd>vertical resize +2<cr>")

-- Navigate Buffers
nnoremap("<S-l>", "<cmd>bnext<cr>")
nnoremap("<S-h>", "<cmd>bprevious<cr>")

-- Insert --
-- Press jk or kj fast to exit Insert Mode
-- Another Way to Change to Normal Mode
inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

-- Visual --
-- Stay in Indent Mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("p", '"_dP')
