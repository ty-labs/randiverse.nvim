local M = {}

M.parse_command_flags = function(args, flag_mappings)
    local flags = {}
    local i = 1

    while i <= #args do
        local arg = args[i]
        local flag = arg:match("^%-%-?(%a+[%a%-]*)$")

        if not flag or flag:match("%-%-+") ~= nil or flag:match("%-$") then
            error("invalid flag format: " .. arg)
        end
        i = i + 1

        local mapped_flag = flag_mappings[flag] or flag
        if i <= #args and not args[i]:match("^%-%-?(%a+[%a%-]*)$") then
            -- TODO: i wonder if this would bug out somehow? (negatives work fine)
            flags[mapped_flag] = args[i]
            i = i + 1
        else
            flags[mapped_flag] = true
        end
    end

    return flags
end

M.validate_and_transform_command_flags = function(expected, received)
    local transformed_flags = {}
    for flag, value in pairs(received) do
        -- perform checks on the command flags --
        -- check if key is fictious
        if not expected[flag] then
            error(string.format("unknown flag passed '%s'", flag))
        end
        -- check if key does not expect value but value provided
        if expected[flag]["bool"] and value ~= true then
            error(string.format("flag '%s' is boolean and does not expect a value", flag))
        end
        -- check if key does expect value but no value provided
        if not expected[flag]["bool"] and value == true then
            error(string.format("flag '%s' expects a value and no value was provided", flag))
        end
        -- run flag validator if non-boolean
        if not expected[flag]["bool"] then
            expected[flag]["validator"](value)
        end

        -- transform the command flags (if applicable) --
        if expected[flag]["bool"] then
            transformed_flags[flag] = true
        else
            transformed_flags[flag] = expected[flag]["transformer"](value)
        end
    end
    -- run cross-flag checks on command flags
    expected["cross_flags_validator"](transformed_flags)
    return transformed_flags
end

-- common validator/transformers for command flags --
M.string_is_integer = function(s)
    local n = tonumber(s)
    return n ~= nil and n == math.floor(n)
end

M.string_is_non_negative_integer = function(s)
    local n = tonumber(s)
    return n ~= nil and n == math.floor(n) and n > -1
end

M.string_is_positive_integer = function(s)
    local n = tonumber(s)
    return n ~= nil and n == math.floor(n) and n > 0
end

M.string_to_integer = function(s)
    return math.floor(tonumber(s) or 0)
end

M.string_is_valid_corpus = function(s)
    return s == "short" or s == "medium" or s == "long"
end

M.string_is_probability = function(s)
    local n = tonumber(s)
    return n ~= nil and n >= 0.0 and n <= 1.0
end

M.string_to_number = function(s)
    return tonumber(s)
end

M.pass_through = function(s)
    return s
end

M.no_validations = function(_) end

-- for assets and reading --
local file_cache = {}

M.read_lines = function(path)
    if file_cache[path] then
        return file_cache[path]
    end
    -- TODO: Error catching?
    local lines = {}
    for line in io.lines(path) do
        table.insert(lines, line)
    end
    file_cache[path] = lines
    return lines
end

M.read_random_line = function(path)
    local lines = M.read_lines(path)
    return lines[math.random(#lines)]
end

M.get_random_from_set = function(set)
    local keys = {}
    for k, _ in pairs(set) do
        table.insert(keys, k)
    end
    return keys[math.random(#keys)]
end

M.concat_table_keys = function(tbl)
    local keys = {}
    for k, _ in pairs(tbl) do
        table.insert(keys, k)
    end
    return table.concat(keys, ",")
end

return M
