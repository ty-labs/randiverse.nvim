local config = require("randiverse.config")
local buffer = require("randiverse.buffer")
local utils = require("randiverse.utils")

-- import commands --
local int = require("randiverse.commands.int")
local float = require("randiverse.commands.float")
local name = require("randiverse.commands.name")
local country = require("randiverse.commands.country")
local word = require("randiverse.commands.word")
local text = require("randiverse.commands.text")

local M = {}

M.setup = function(user_opts)
	config.setup(user_opts)
end

M.buffer_setup = function(buffer_opts)
	config.buffer_setup(buffer_opts)
end

local randiverse_commands = {
	int = int.normal_random_int,
	float = float.normal_random_float,
	name = name.normal_random_name,
	country = country.normal_random_country,
	word = word.normal_random_word,
	text = text.normal_random_text,
}

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
	local random_output = randiverse_commands[command](remaining_args)
	buffer.curpos_insert_text(random_output)
	print("finished randiverse command")
end

return M
