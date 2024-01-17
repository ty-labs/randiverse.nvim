local config = require("randiverse.config")
local utils = require("randiverse.utils")

local country = require("randiverse.commands.country")
local datetime = require("randiverse.commands.datetime")
local email = require("randiverse.commands.email")
local float = require("randiverse.commands.float")
local hexcolor = require("randiverse.commands.hexcolor")
local int = require("randiverse.commands.int")
local ip = require("randiverse.commands.ip")
local lorem = require("randiverse.commands.lorem")
local name = require("randiverse.commands.name")
local url = require("randiverse.commands.url")
local uuid = require("randiverse.commands.uuid")
local word = require("randiverse.commands.word")

local M = {}

M.setup = function(user_opts)
    config.setup(user_opts)
end

local randiverse_commands = {
    country = country.normal_random_country,
    datetime = datetime.normal_random_datetime,
    email = email.normal_random_email,
    float = float.normal_random_float,
    int = int.normal_random_int,
    hexcolor = hexcolor.normal_random_hexcolor,
    ip = ip.normal_random_ip,
    lorem = lorem.normal_random_lorem,
    name = name.normal_random_name,
    url = url.normal_random_url,
    uuid = uuid.normal_random_uuid,
    word = word.normal_random_word,
}

M.randiverse_completion = function(findstart, base)
    if findstart == 1 then
        -- When findstart is 1, return the start position of completion
        return vim.fn.col(".") - 1
    else
        -- When findstart is 0, return completion suggestions based on the base string
        local matches = {}
        print("HERE")

        for key, _ in pairs(randiverse_commands) do
            if key:match("^" .. base) then
                table.insert(matches, key)
            end
        end
        return matches
    end
end

M.randiverse = function(args)
    if #args < 1 then
        vim.api.nvim_err_writeln("Randiverse requires at least 1 command argument.")
        return
    end
    local command = args[1]
    if not randiverse_commands[command] then
        vim.api.nvim_err_writeln(string.format("'%s' is not a known Randiverse command.", command))
        return
    end
    local remaining_args = utils.slice_table(args, 2, #args)
    local success, random_output = pcall(randiverse_commands[command], remaining_args)
    if not success then
        vim.api.nvim_err_writeln(string.format("Error in Randiverse '%s': %s", command, random_output))
        return
    end
    vim.api.nvim_put({ random_output }, "", true, true)
end

return M
