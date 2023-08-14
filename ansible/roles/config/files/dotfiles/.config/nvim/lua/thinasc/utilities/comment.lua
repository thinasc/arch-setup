local status_comment, comment = pcall(require, "Comment")
if not status_comment then
	return
end

comment.setup({
	ignore = "^$",
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		local status_utils, utils = pcall(require, "ts_context_commentstring.utils")
		if not status_utils then
			return
		end

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = utils.get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = utils.get_visual_start_location()
		end

		local status_internals, internals = pcall(require, "ts_context_commentstring.internals")
		if not status_internals then
			return
		end

		return internals.calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
})
