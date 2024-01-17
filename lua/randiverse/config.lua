local M = {}

M.default_opts = {
    enabled = true,
    keymaps_enabled = true,
    keymaps = {
        country = {
            keymap = "<leader>rc",
            command = "country",
            desc = "Generates a random country",
        },
        datetime = {
            keymap = "<leader>rd",
            command = "datetime",
            desc = "Generates a random datetime",
        },
        email = {
            keymap = "<leader>re",
            command = "email",
            desc = "Generates a random email address",
        },
        float = {
            keymap = "<leader>rf",
            command = "float",
            desc = "Generates a random float",
        },
        hexcolor = {
            keymap = "<leader>rh",
            command = "hexcolor",
            desc = "Generates a random hexcolor",
        },
        int = {
            keymap = "<leader>ri",
            command = "int",
            desc = "Generates a random integer",
        },
        ip = {
            keymap = "<leader>rI",
            command = "ip",
            desc = "Generates a random ip",
        },
        lorem = {
            keymap = "<leader>rl",
            command = "lorem",
            desc = "Generates random lorem ipsum text",
        },
        name = {
            keymap = "<leader>rn",
            command = "name",
            desc = "Generates a random name",
        },
        url = {
            keymap = "<leader>ru",
            command = "url",
            desc = "Generates a random url",
        },
        uuid = {
            keymap = "<leader>rU",
            command = "uuid",
            desc = "Generates a random uuid",
        },
        word = {
            keymap = "<leader>rw",
            command = "word",
            desc = "Generates a random word",
        },
    },
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
        datetime = {
            formats = {
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
            },
            default_formats = {
                datetime = "iso",
                date = "iso",
                time = "iso",
            },
        },
        email = {
            domains = { "example", "company", "mail", "test", "random" },
            tlds = { "com", "net", "org", "dev", "edu" },
            digits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" },
            specials = { "!", "#", "$", "%", "^", "&", "*" },
            separators = { "_", "-", "." },
            default_digits = 0,
            default_specials = 0,
            default_muddle_property = 0.0,
        },
        float = {
            default_start = 1,
            default_stop = 100,
            default_decimals = 2,
        },
        int = {
            default_start = 1,
            default_stop = 100,
        },
        lorem = {
            corpuses = {
                ["lorem"] = "words_lorem.txt",
            },
            sentence_lengths = {
                ["short"] = { 5, 20 },
                ["medium"] = { 20, 40 },
                ["long"] = { 40, 60 },
                ["mixed-short"] = { 5, 30 },
                ["mixed"] = { 5, 100 },
                ["mixed-long"] = { 30, 100 },
            },
            default_corpus = "lorem",
            default_sentence_length = "mixed-short",
            default_comma_property = 0.1,
            default_length = 100,
        },
        name = {
            FIRST = "names_first.txt",
            LAST = "names_last.txt",
        },
        url = {
            protocols = { "http", "https" },
            tlds = { "com", "org", "net", "edu", "gov" },
            default_domain_corpus = "medium",
            default_subdomain_corpus = "short",
            default_path_corpus = "medium",
            default_fragment_corpus = "long",
            default_param_corpus = "medium",
            default_value_corpus = "medium",
            default_subdomains = 0,
            default_paths = 0,
            default_query_params = 0,
        },
        word = {
            corpuses = {
                ["short"] = "words_short.txt",
                ["medium"] = "words_medium.txt",
                ["long"] = "words_long.txt",
            },
            default_corpus = "medium",
            default_length = 1,
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
    vim.api.nvim_set_keymap(args.mode, args.lhs, args.rhs, args.opts)
end

M.set_keymaps = function()
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.country.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.country.command),
        opts = {
            desc = M.user_opts.keymaps.country.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.datetime.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.datetime.command),
        opts = {
            desc = M.user_opts.keymaps.datetime.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.email.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.email.command),
        opts = {
            desc = M.user_opts.keymaps.email.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.float.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.float.command),
        opts = {
            desc = M.user_opts.keymaps.float.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.hexcolor.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.hexcolor.command),
        opts = {
            desc = M.user_opts.keymaps.hexcolor.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.int.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.int.command),
        opts = {
            desc = M.user_opts.keymaps.int.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.ip.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.ip.command),
        opts = {
            desc = M.user_opts.keymaps.ip.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.lorem.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.lorem.command),
        opts = {
            desc = M.user_opts.keymaps.lorem.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.name.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.name.command),
        opts = {
            desc = M.user_opts.keymaps.name.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.url.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.url.command),
        opts = {
            desc = M.user_opts.keymaps.url.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.uuid.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.uuid.command),
        opts = {
            desc = M.user_opts.keymaps.uuid.desc,
            noremap = true,
            silent = true,
        },
    })
    M.set_keymap({
        mode = "n",
        lhs = M.user_opts.keymaps.word.keymap,
        rhs = string.format(":Randiverse %s<CR>", M.user_opts.keymaps.word.command),
        opts = {
            desc = M.user_opts.keymaps.word.desc,
            noremap = true,
            silent = true,
        },
    })
end

-- TODO: Validate config inputs? (Files are readable, Defaults not nil + readable, Commands, etc.)
M.setup = function(user_opts)
    -- 1st overwrite default options w/ potential user-defined if exist
    M.user_opts = vim.tbl_deep_extend("force", M.default_opts, user_opts or {})

    if not M.user_opts.enabled then
        return
    end

    -- 2nd register the command
    vim.cmd(
        [[command! -nargs=* -complete=customlist,v:lua.require('randiverse').auto_completion Randiverse lua require('randiverse').randiverse({<f-args>})]]
    )

    -- 3rd register the keymaps if applicable
    if M.user_opts.keymaps_enabled then
        M.set_keymaps()
    end

    -- 4th set seed for randomness
    math.randomseed(os.time())
end

return M
