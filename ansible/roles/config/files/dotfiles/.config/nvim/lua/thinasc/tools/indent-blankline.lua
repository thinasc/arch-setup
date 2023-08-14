local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
	return
end

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
-- vim.opt.listchars:append "space:⋅"
-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
-- vim.wo.colorcolumn = "99999"

-- Set Colors
-- vim.cmd([[highlight IndentBlanklineIndent guifg=#3A405F gui=nocombine]])
-- vim.cmd([[highlight IndentSpaceIndent guifg=#3A405F gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#D6ACFF gui=nocombine]])

indent_blankline.setup({
	show_end_of_line = true,
	-- char_highlight_list = {
	--   "IndentBlanklineIndent",
	-- },
	-- space_char_highlight_list = {
	--   "IndentSpaceIndent",
	-- },
	-- space_char_blankline            = " ",
	-- show_current_context            = true,
	-- show_current_context_start      = true,
	-- show_trailing_blankline_indent  = false,
	-- indent_blankline_use_treesitter = true,
})
