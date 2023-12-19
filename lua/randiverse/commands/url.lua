local utils = require("randiverse.commands.utils")

local M = {}

local expected_flags = {
	["subdomain"] = {
		bool = true,
	},
	["path"] = {
		bool = true,
	},
}

local flag_mappings = {
	s = "subdomain",
	p = "path",
	q = "query-params",
	f = "fragement",
}

-- create flags to add addition of # query params + fragement + subdomains + path
M.normal_random_url = function(args)
	print("inside normal_random_email")
	args = args or {}
	local parsed_flags = utils.parse_command_flags(args, flag_mappings)
	local transformed_flags = utils.validate_and_transform_command_flags(expected_flags, parsed_flags)

	-- allow protocols/tld to be overridden in plugin configuration --
	local protocols = { "http", "https" }
	local domain = utils.read_random_line(utils.get_asset_path() .. utils.WORDS_LONG_FILE)
	if transformed_flags["subdomain"] then
		local subdomain = utils.read_random_line(utils.get_asset_path() .. utils.WORDS_SHORT_FILE)
		domain = string.format("%s.%s", subdomain, domain)
	end
	local tld = { "com", "org", "net", "edu", "gov" }

	local random_url = string.format("%s://%s.%s", protocols[math.random(#protocols)], domain, tld[math.random(#tld)])

	-- add path, params, then fragement if requested

	print("finished normal_random_email")
	return random_url
end

return M
