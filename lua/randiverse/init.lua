local config = require("randiverse.config")
local buffer = require("randiverse.buffer")
local utils = require("randiverse.utils")

local M = {}

M.setup = function(user_opts)
	config.setup(user_opts)
end

M.buffer_setup = function(buffer_opts)
	config.buffer_setup(buffer_opts)
end

local randiverse_commands = {
	int = function(args)
		return M.normal_random_int(args)
	end,
	float = function(args)
		return M.normal_random_float(args)
	end,
	name = function(args)
		return M.normal_random_name(args)
	end,
	fname = function(args)
		return M.normal_random_fname(args)
	end,
	lname = function(args)
		return M.normal_random_lname(args)
	end,
	country = function(args)
		return M.normal_random_country(args)
	end,
	phone = function(args)
		return M.normal_random_phone(args)
	end,
	letters = function(args)
		return M.normal_random_letters(args)
	end,
	lorem = function(args)
		return M.normal_random_lorem(args)
	end,
	word = function(args)
		return M.normal_random_word(args)
	end,
	date = function(args)
		return M.normal_random_date(args)
	end,
}

-- TODO: random functions return a string! Randiverse function actually inserts (w/ high-level flags in effect)
M.randiverse = function(args)
	print("starting randiverse command")
	if #args < 1 then
		vim.api.nvim_err_writeln("Randiverse requires at least 1 type argument.")
		return
	end
	local command = args[1]
	local remaining_args = utils.slice_table(args, 2, #args)
	if not randiverse_commands[command] then
		vim.api.nvim_err_writeln("`" .. command .. "` is not a known Randiverse command.")
		return
	end
	local output = randiverse_commands[command](remaining_args)
	buffer.curpos_insert_text(output)
	print("finished randiverse command")
end

-- TODO: Refactor below functions in separate Lua modules to handle args & processing
M.normal_random_int = function(args)
	print("inside normal_random_int")
	args = args or {}
	local rand_int = tostring(math.random(-100, 100))
	print("finished normal_random_int")
	return rand_int
end

M.normal_random_float = function(args)
	print("inside normal_random_float")
	print("finished normal_random_float")
end

M.normal_random_name = function(args)
	print("inside normal_random_float")
	args = args or {}
	for i = 1, #args do
		print(args[i])
	end
	local path = debug.getinfo(2, "S").source:sub(2)
	path = path:match("(.*/)")
	local fname = utils.read_random_line(path .. "assets/first-names.txt")
	local lname = utils.read_random_line(path .. "assets/last-names.txt")
	print("finished normal_random_float")
	return fname .. " " .. lname
end

M.normal_random_fname = function(args) end

M.normal_random_lname = function(args) end

M.normal_random_country = function(args) end

M.normal_random_phone = function(args) end

M.normal_random_letters = function(args) end

M.normal_random_lorem = function(args) end

M.normal_random_word = function(args) end

M.normal_random_date = function(args) end

return M
