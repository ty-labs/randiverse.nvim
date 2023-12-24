local M = {}

M.default_opts = {
    keymaps = {},
    data = {
        ROOT = (function()
            local path = debug.getinfo(1, "S").source:sub(2)
            path = path:match("(.*/)")
            return path .. "data/"
        end)(),
        country = {
            COUNTRIES = "countries.txt",
            ALPHA2 = "countries_alpha2.txt",
            ALPHA3 = "countries_alpha3.txt",
            NUMERIC = "countries_numeric.txt",
        },
        email = {},
        lorem = {},
        name = {
            FIRST = "names_first.txt",
            LAST = "names_last.txt",
        },
        url = {},
        word = {
            SHORT = "words_short.txt",
            MEDIUM = "words_medium.txt",
            LONG = "words_long.txt",
        },
    },
}

-- stores the global user-set options for the plugin (default where none passed) --
M.user_opts = nil

M.get_data_root_dir = function()
    return M.user_opts.data.root
end

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
    -- 1st overwrite default options w/ potential user-defined if exist
    M.user_opts = vim.tbl_deep_extend("force", M.default_opts, user_opts or {})

    -- 1st register the command
    vim.cmd([[command! -nargs=* Randiverse lua require('randiverse').randiverse({<f-args>})]])

    -- TODO: 2nd register the keymaps which call command w/ args

    -- 3rd set seed for randomness
    math.randomseed(os.time())
end

M.buffer_setup = function() end

return M
