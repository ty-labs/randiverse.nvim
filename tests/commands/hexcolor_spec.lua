local hexcolor = require("randiverse.commands.hexcolor")

describe("Randiverse 'hexcolor' command", function()
    it("should return a random hexcolor with no flags", function()
        for _ = 1, 50 do
            local success, random_hexcolor = pcall(hexcolor.normal_random_hexcolor, {})
            assert.is_true(success)
            assert.same(type(random_hexcolor), "string")
            local r, g, b = random_hexcolor:match("^#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])$")
            assert.is_truthy(r, g, b)
        end
    end)

    it("should return a random hexcolor with '-l' flags", function()
        for _ = 1, 50 do
            local success, random_hexcolor = pcall(hexcolor.normal_random_hexcolor, {
                "-l",
            })
            assert.is_true(success)
            assert.same(type(random_hexcolor), "string")
            local r, g, b = random_hexcolor:match("^#([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])$")
            assert.is_truthy(r, g, b)
        end
    end)

    it("should return a random hexcolor with '--lowercase' flags", function()
        for _ = 1, 50 do
            local success, random_hexcolor = pcall(hexcolor.normal_random_hexcolor, {
                "--lowercase",
            })
            assert.is_true(success)
            assert.same(type(random_hexcolor), "string")
            local r, g, b = random_hexcolor:match("^#([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])([0-9a-f][0-9a-f])$")
            assert.is_truthy(r, g, b)
        end
    end)

    it("should error when called with '-l' and a value", function()
        local success, error = pcall(hexcolor.normal_random_hexcolor, {
            "-l",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is boolean and does not expect a value"))
    end)

    it("should error when called with '--lowercase' and a value", function()
        local success, error = pcall(hexcolor.normal_random_hexcolor, {
            "--lowercase",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(hexcolor.normal_random_hexcolor, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(hexcolor.normal_random_hexcolor, {
            "-quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
