local int = require("randiverse.commands.int")

describe("Randiverse 'int' command", function()
    it("should return a random int between [1, 100] with no flags", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {})
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 1 and n <= 100)
        end
    end)

    it("should return a random int between [1, 50] with '-S 50' flag", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "-S",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 1 and n <= 50)
        end
    end)

    it("should return a random int between [50, 100] with '-s 50' flag", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "-s",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 50 and n <= 100)
        end
    end)

    it("should return a random int between [1, 50] with '--stop 50' flag", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "--stop",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 1 and n <= 50)
        end
    end)

    it("should return a random int between [50, 100] with '--start 50' flag", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "--start",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 50 and n <= 100)
        end
    end)

    it("should return a random int between [-100, -1] with '-s -100 -S -1' flags", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "-s",
                "-100",
                "-S",
                "-1",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= -100 and n <= -1)
        end
    end)

    it("should return a random int between [0, 0] with '--start 0 --stop 0' flags", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "--start",
                "0",
                "--stop",
                "0",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 0 and n <= 0)
        end
    end)

    it("should return a random int between [0, 1] with '--start 0 --stop 1' flags", function()
        for _ = 1, 50 do
            local success, random_int = pcall(int.normal_random_int, {
                "--start",
                "0",
                "--stop",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_int), "string")
            local n = tonumber(random_int)
            assert.is_true(n ~= nil and n == math.floor(n))
            assert.is_true(n >= 0 and n <= 1)
        end
    end)

    it("should error when called with '-s 1 -S 0' flags", function()
        local success, error = pcall(int.normal_random_int, {
            "-s",
            "1",
            "-S",
            "0",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "the range stop can not be less than range start"))
    end)

    it("should error when called with '-s' flag and no value", function()
        local success, error = pcall(int.normal_random_int, {
            "-s",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'start' expects a value and no value was provided"))
    end)

    it("should error when called with '-s' flag and invalid value", function()
        local success, error = pcall(int.normal_random_int, {
            "-s",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'start' can not accept value 'dummy': value must be an integer"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(int.normal_random_int, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(int.normal_random_int, {
            "-quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
