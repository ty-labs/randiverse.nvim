local M = {}

M.slice_table = function(tbl, start, stop)
	local sliced = {}

	start = start or 1
	stop = stop or #tbl

	for i = start, stop do
		table.insert(sliced, tbl[i])
	end

	return sliced
end

M.read_random_line = function(path)
	local file, error = io.open(path, "r")
	if not file then
		print("Error opening file:", error)
		vim.api.nvim_err_writeln("Unable to open file")
		return
	end

	local file_size = file:seek("end")
	file:seek("set", 0)

	local random_position = math.random(file_size)

	-- TODO: there is a basecase to consider if we had chosen last line already...
	-- TODO: there needs to be a caching mechansim for file lengths to speed up process...
	file:seek("set", random_position)
	_ = file:read()

	local line = file:read("*l")
	file:close()
	return line
end

return M
