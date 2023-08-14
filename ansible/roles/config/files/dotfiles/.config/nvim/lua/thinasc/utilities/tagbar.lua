local status, tagbar = pcall(require, "tagbar")
if not status then
	return
end

tagbar.setup()
