local M = {}

M.default_opts = {
    keymaps = {
        -- TODO: These will likely be <leader>r<first-letter-of-command> => calls default randiverse command but can be changed!
    },
    enabled = true, -- TODO: Enables setup + register of command
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
        email = {
            domains = {},
            tlds = {},
        },
        lorem = {},
        name = {
            FIRST = "names_first.txt",
            LAST = "names_last.txt",
        },
        url = {
            protocols = {},
            tlds = {},
        },
        word = {
            corpuses = {
                ["short"] = "words_short.txt",
                ["medium"] = "words_medium.txt",
                ["long"] = "words_long.txt",
            },
            default = "medium",
        },
    },
    formats = {
        datetime = {
            datetime = {
                iso = "%Y-%m-%dT%H:%M:%SZ",
                rfc = "%a, %d %b %Y %H:%M:%S",
                sortable = "%Y%m%d%H%M%S",
                human = "%B %d, %Y %I:%M:%S %p",
                short = "%m/%d/%y %H:%M:%S",
                long = "%A, %B %d, %Y %I:%M:%S %p",
                epoch = "%s",
            },
            date = {
                iso = "%Y-%m-%d",
                rfc = "%a, %d %b %Y",
                sortable = "%Y%m%d",
                human = "%B %d, %Y",
                short = "%m/%d/%y",
                long = "%A, %B %d, %Y",
                epoch = "%s",
            },
            time = {
                iso = "%H:%M:%S",
                rfc = "%H:%M:%S",
                sortable = "%H%M%S",
                human = "%I:%M:%S %p",
                short = "%H:%M:%S",
                long = "%%I:%M:%S %p",
            },
            defaults = { -- TODO: Defaults should be keys like in 'word' (no repeats)
                datetime = "%Y-%m-%dT%H:%M:%SZ",
                date = "%Y-%m-%d",
                time = "%H:%M:%S",
            },
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
