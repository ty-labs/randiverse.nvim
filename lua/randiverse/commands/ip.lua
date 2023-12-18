local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	version = {
		bool = false,
		validator = function(s)
			return s == "ipv4" or s == "4" or s == "ipv6" or s == "6"
		end,
		transformer = function(s)
			if s == "ipv4" or s == "ipv6" then
				return s
			end
			if s == "4" then
				return "ipv4"
			end
			return "ipv6"
		end,
	},
}

local flag_mappings = {
	v = "version",
}

local ip_generators = {
	ipv4 = function()
		local ipv4_blocks = {}
		for _ = 1, 4 do
			table.insert(ipv4_blocks, math.random(0, 255))
		end
		return table.concat(ipv4_blocks, ".")
	end,
	ipv6 = function()
		local ipv6_blocks = {}
		for _ = 1, 8 do
			table.insert(ipv6_blocks, string.format("%04x", math.random(0, 65535)))
		end
		return table.concat(ipv6_blocks, ":")
	end,
}

M.normal_random_ip = function(args)
	print("inside normal_random_ip")

	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	local random_ip = ""
	if not transformed_flags["version"] then
		random_ip = ip_generators["ipv4"]()
	else
		random_ip = ip_generators[transformed_flags["version"]]()
	end

	print("finished normal_random_ip")
	return random_ip
end

return M
