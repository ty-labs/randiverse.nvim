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

M.randiverse = function(args)
    if #args < 1 then
        vim.api.nvim_err_writeln("Randiverse requires at least 1 command argument.")
        return
    end
    local command = args[1]
    local remaining_args = utils.slice_table(args, 2, #args)
    if not randiverse_commands[command] then
        vim.api.nvim_err_writeln("`" .. command .. "` is not a known Randiverse command.")
        return
    end
    local success, random_output = pcall(randiverse_commands[command], remaining_args)
    if not success then
        vim.api.nvim_err_writeln("Error in Randiverse: " .. random_output)
        return
    end
    vim.api.nvim_put({ tostring(random_output) }, "", true, true)
end

return M
