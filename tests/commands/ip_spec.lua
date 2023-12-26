local ip = require("randiverse.commands.ip")

local ipv6_pattern = (function()
    local blocks = {}
    for _ = 1, 8 do
        table.insert(blocks, "([0-9A-F][0-9A-F][0-9A-F][0-9A-F])")
    end
    local pattern = table.concat(blocks, ":")
    pattern = "^" .. pattern .. "$"
    return pattern
end)()

local ipv6_l_pattern = (function()
    local blocks = {}
    for _ = 1, 8 do
        table.insert(blocks, "([0-9a-f][0-9a-f][0-9a-f][0-9a-f])")
    end
    local pattern = table.concat(blocks, ":")
    pattern = "^" .. pattern .. "$"
    return pattern
end)()

describe("Randiverse 'ip' command", function()
    it("should return a random ip with no flags", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {})
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4 = random_ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
            assert.is_truthy(b1, b2, b3, b4)
        end
    end)

    it("should return a random ip with '-v 4' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-v",
                "4",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4 = random_ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
            assert.is_truthy(b1, b2, b3, b4)
        end
    end)

    it("should return a random ip with '-v ipv4' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-v",
                "ipv4",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4 = random_ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
            assert.is_truthy(b1, b2, b3, b4)
        end
    end)

    it("should return a random ip with '--version 4' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--version",
                "4",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4 = random_ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
            assert.is_truthy(b1, b2, b3, b4)
        end
    end)

    it("should return a random ip with '--version ipv4' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--version",
                "ipv4",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4 = random_ip:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
            assert.is_truthy(b1, b2, b3, b4)
        end
    end)

    it("should return a random ip with '-v 6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-v",
                "6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '-v ipv6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-v",
                "ipv6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '--version 6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--version",
                "6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '--version ipv6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--version",
                "ipv6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '-v 6 -l' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-v",
                "6",
                "-l",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_l_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '-l -v ipv6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "-l",
                "-v",
                "ipv6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_l_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '--version 6 -l' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--version",
                "6",
                "-l",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_l_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should return a random ip with '--lowercase --version ipv6' flag", function()
        for _ = 1, 50 do
            local success, random_ip = pcall(ip.normal_random_ip, {
                "--lowercase",
                "--version",
                "ipv6",
            })
            assert.is_true(success)
            assert.same(type(random_ip), "string")
            local b1, b2, b3, b4, b5, b6, b7, b8 = random_ip:match(ipv6_l_pattern)
            assert.is_truthy(b1, b2, b3, b4, b5, b6, b7, b8)
        end
    end)

    it("should error when called with only '-l' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "-l",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is only applicable with '%-%-version ipv6'"))
    end)

    it("should error when called with only '--lowercase' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "--lowercase",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is only applicable with '%-%-version ipv6'"))
    end)

    it("should error when called with only '--lowercase --version ipv4' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "--lowercase",
            "--version",
            "ipv4",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is only applicable with '%-%-version ipv6'"))
    end)

    it("should error when called with only '--lowercase --version 4' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "--lowercase",
            "--version",
            "4",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is only applicable with '%-%-version ipv6'"))
    end)

    it("should error when called with '-l' and a value", function()
        local success, error = pcall(ip.normal_random_ip, {
            "-l",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is boolean and does not expect a value"))
    end)

    it("should error when called with '--lowercase' and a value", function()
        local success, error = pcall(ip.normal_random_ip, {
            "--lowercase",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "-v",
            "6",
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(ip.normal_random_ip, {
            "--version",
            "ipv6",
            "--quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
