local M = {}

--@type user_options
M.default_opts = {
	keymaps = {},
}

M.set_keymap = function(args)
	if not args.lhs then
		if not M.user_opts.keymaps[args.name] then
			return
		end
		args.lhs = M.user_opts.keymaps[args.name]
		args.rhs = "<NOP>"
	end
	vim.keymap.set(args.mode, args.lhs, args.rhs, args.opts)
end

-- TODO: Enable ability to override any command default values to user desire
M.setup = function(user_opts)
	-- 1st register the command
	vim.cmd([[command! -nargs=* Randiverse lua require('randiverse').randiverse({<f-args>})]])
	-- TODO: 2nd register the keymaps which call command w/ args

	-- 3rd set seed for randomness
	math.randomseed(os.time())
end

M.buffer_setup = function(buffer_opts) end

return M
