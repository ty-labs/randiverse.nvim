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

return M
