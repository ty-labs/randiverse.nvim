local utils = require("randiverse.utils")

local M = {}

M.normal_random_name = function(args)
	print("inside normal_random_name")
	args = args or {}
	for i = 1, #args do
		print(args[i])
	end
	local path = debug.getinfo(2, "S").source:sub(2)
	path = path:match("(.*/)")
	local fname = utils.read_random_line(path .. "assets/first-names.txt")
	local lname = utils.read_random_line(path .. "assets/last-names.txt")
	print("finished normal_random_name")
	return fname .. " " .. lname
end

return M
