local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
local ctrl_c = vim.api.nvim_replace_termcodes("<C-c>", true, false, true)
local ctr_v = vim.api.nvim_replace_termcodes("<C-v>", true, false, true)
local set_curpos = function(pos)
	vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] - 1 })
end
local set_lines = function(lines)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end
local check_lines = function(lines)
	assert.are.same(lines, vim.api.nvim_buf_get_lines(0, 0, -1, false))
end

describe("randiverse basics", function()
	before_each(function()
		-- create & set the testing nvim testing buffer
		local bufnr = vim.api.nvim_create_buf(true, true)
		vim.api.nvim_win_set_buf(0, bufnr)
	end)

	it("test randiverse int command", function()
		set_lines({ 'value: ""' })
		set_curpos({ 1, 9 })
		vim.cmd("Randiverse int")
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		for _, line in ipairs(lines) do
			print(line)
		end
	end)

	it("test randiverse name command", function()
		vim.cmd("Randiverse name")
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		for _, line in ipairs(lines) do
			print(line)
		end
	end)
end)
