local config = require("randiverse.config")
local datetime = require("randiverse.commands.datetime")

describe("Randiverse 'datetime' command", function()
    it("should return a datetime with no flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {})
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day, hour, min, sec = random_datetime:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z$")
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.datetime[config.user_opts.data.datetime.default_formats.datetime],
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                min = min,
                sec = sec,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a date with '-d' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-d",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day = random_datetime:match("^(%d+)-(%d+)-(%d+)$")
        assert.is_truthy(year and month and day)
        local replica = os.date(
            config.user_opts.data.datetime.formats.date[config.user_opts.data.datetime.default_formats.date],
            os.time({
                year = year,
                month = month,
                day = day,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a date with '--date' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "--date",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day = random_datetime:match("^(%d+)-(%d+)-(%d+)$")
        assert.is_truthy(year and month and day)
        local replica = os.date(
            config.user_opts.data.datetime.formats.date[config.user_opts.data.datetime.default_formats.date],
            os.time({
                year = year,
                month = month,
                day = day,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a time with '-t' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-t",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local hour, min, sec = random_datetime:match("^(%d+):(%d+):(%d+)$")
        local year, month, day = os.date("*t").year, 1, 1
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.time[config.user_opts.data.datetime.default_formats.time],
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                sec = sec,
                min = min,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a time with '--time' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "--time",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local hour, min, sec = random_datetime:match("^(%d+):(%d+):(%d+)$")
        local year, month, day = os.date("*t").year, 1, 1
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.time[config.user_opts.data.datetime.default_formats.time],
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                sec = sec,
                min = min,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a datetime with '-d -t' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-d",
            "-t",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day, hour, min, sec = random_datetime:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z$")
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.datetime[config.user_opts.data.datetime.default_formats.datetime],
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                min = min,
                sec = sec,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a datetime with '--date --time' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "--date",
            "--time",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day, hour, min, sec = random_datetime:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z$")
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.datetime[config.user_opts.data.datetime.default_formats.datetime],
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                min = min,
                sec = sec,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a iso datetime with '-f iso' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-f",
            "iso",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day, hour, min, sec = random_datetime:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z$")
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.datetime.iso,
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                min = min,
                sec = sec,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a iso datetime with '--format iso' flag", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-format",
            "iso",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day, hour, min, sec = random_datetime:match("^(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z$")
        assert.is_truthy(year and month and day and hour and min and sec)
        local replica = os.date(
            config.user_opts.data.datetime.formats.datetime.iso,
            os.time({
                year = year,
                month = month,
                day = day,
                hour = hour,
                min = min,
                sec = sec,
            })
        )
        assert.same(random_datetime, replica)
    end)

    it("should return a time with '-t -f human' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-t",
            "-f",
            "human",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local hour, min, sec, period = random_datetime:match("^(%d+):(%d+):(%d+) (%a+)$")
        assert.is_truthy(hour and min and sec and period)
    end)

    it("should return a time with '--time --format sortable' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "--time",
            "--format",
            "sortable",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local hour, min, sec = random_datetime:match("^(%d%d)(%d%d)(%d%d)$")
        assert.is_truthy(hour and min and sec)
    end)

    it("should return a date with '-d -f rfc' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "-d",
            "-f",
            "rfc",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day = random_datetime:match("^(%a+), (%d+) (%a+) (%d+)$")
        assert.is_truthy(year and month and day)
    end)

    it("should return a date with '--date --format long' flags", function()
        local success, random_datetime = pcall(datetime.normal_random_datetime, {
            "--date",
            "--format",
            "long",
        })
        assert.is_true(success)
        assert.same(type(random_datetime), "string")
        random_datetime = tostring(random_datetime)
        local year, month, day = random_datetime:match("^(%a+), (%a+) (%d+), (%d+)$")
        assert.is_truthy(year and month and day)
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "-q",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "-quiet",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)

    it("should error when called with '-f' flag and no value", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "-f",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(string.find(error, "flag 'format' expects a value and no value was provided"))
    end)

    it("should error when called with '--format' flag and no value", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "--format",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(string.find(error, "flag 'format' expects a value and no value was provided"))
    end)

    it("should error when called with '-f' flag and invalid value", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "--format",
            "lengthy",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(
            string.find(error, "flag 'format' can not accept value 'lengthy': value must be one of the following")
        )
    end)

    it("should error when called with '-d' flag and a value", function()
        local success, error = pcall(datetime.normal_random_datetime, {
            "-d",
            "iso",
        })
        assert.is_false(success)
        error = tostring(error)
        assert.is_truthy(string.find(error, "flag 'date' is boolean and does not expect a value"))
    end)
end)
