local float = require("randiverse.commands.float")

describe("Randiverse 'float' command", function()
    it("should return a random float between [1, 100] with no flags", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {})
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 1 and n <= 100)
        end
    end)

    it("should return a random float between [1, 50] with '-S 50' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "-S",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 1 and n <= 50)
        end
    end)

    it("should return a random float between [50, 100] with '-s 50' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "-s",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 50 and n <= 100)
        end
    end)

    it("should return a random float between [1, 50] with '--stop 50' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "--stop",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 1 and n <= 50)
        end
    end)

    it("should return a random float between [50, 100] with '--start 50' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "--start",
                "50",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 50 and n <= 100)
        end
    end)

    it("should return a random float between [-100, -1] with '-s -100 -S -1' flags", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "-s",
                "-100",
                "-S",
                "-1",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= -100 and n <= -1)
        end
    end)

    it("should return a random float between [0, 0] with '--start 0 --stop 0' flags", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "--start",
                "0",
                "--stop",
                "0",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 0 and n <= 0)
        end
    end)

    it("should return a random float between [0, 1] with '--start 0 --stop 1' flags", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "--start",
                "0",
                "--stop",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 0 and n <= 1)
        end
    end)

    it("should return a random 5-decimal float between [1, 100] with '-d 5' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "-d",
                "5",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d%d%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 1 and n <= 100)
        end
    end)

    it("should return a random 5-decimal float between [1, 100] with '--decimals 5' flag", function()
        for _ = 1, 50 do
            local success, random_float = pcall(float.normal_random_float, {
                "--decimals",
                "5",
            })
            assert.is_true(success)
            assert.same(type(random_float), "string")
            local decimals = random_float:match("^.+%.(%d%d%d%d%d)$")
            assert.is_truthy(decimals)
            local n = tonumber(random_float)
            assert.is_true(n ~= nil)
            assert.is_true(n >= 1 and n <= 100)
        end
    end)

    it("should error when called with '-s 1 -S 0' flags", function()
        local success, error = pcall(float.normal_random_float, {
            "-s",
            "1",
            "-S",
            "0",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "the range stop can not be less than range start: currently %[1, 0%]"))
    end)

    it("should error when called with '-s' flag and no value", function()
        local success, error = pcall(float.normal_random_float, {
            "-s",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'start' expects a value and no value was provided"))
    end)

    it("should error when called with '-s' flag and invalid value", function()
        local success, error = pcall(float.normal_random_float, {
            "-s",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'start' can not accept value 'dummy': value must be an integer"))
    end)

    it("should error when called with '-d' flag and no value", function()
        local success, error = pcall(float.normal_random_float, {
            "-d",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'decimals' expects a value and no value was provided"))
    end)

    it("should error when called with '-d' flag and negative value", function()
        local success, error = pcall(float.normal_random_float, {
            "-d",
            "-1",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'decimals' can not accept value '%-1': value must be a non%-negative integer")
        )
    end)

    it("should error when called with '-d' flag and invalid value", function()
        local success, error = pcall(float.normal_random_float, {
            "-d",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(
            string.find(error, "flag 'decimals' can not accept value 'dummy': value must be a non%-negative integer")
        )
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(float.normal_random_float, {
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(float.normal_random_float, {
            "-quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
