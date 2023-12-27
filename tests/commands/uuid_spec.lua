local uuid = require("randiverse.commands.uuid")

local uuid_pattern = (
    "^[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]"
    .. "%-"
    .. "[0-9A-F][0-9A-F][0-9A-F][0-9A-F]"
    .. "%-"
    .. "4[0-9A-F][0-9A-F][0-9A-F]"
    .. "%-"
    .. "[8-9A-B][0-9A-F][0-9A-F][0-9A-F]"
    .. "%-"
    .. "[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]$"
)

local uuid_l_pattern = (
    "^[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
    .. "%-"
    .. "[0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
    .. "%-"
    .. "4[0-9a-f][0-9a-f][0-9a-f]"
    .. "%-"
    .. "[8-9a-b][0-9a-f][0-9a-f][0-9a-f]"
    .. "%-"
    .. "[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$"
)

describe("Randiverse 'uuid' command", function()
    it("should return a random uuid with no flags", function()
        for _ = 1, 50 do
            local success, random_uuid = pcall(uuid.normal_random_uuid, {})
            assert.is_true(success)
            assert.same(type(random_uuid), "string")
            local match = random_uuid:match(uuid_pattern)
            assert.is_truthy(match)
        end
    end)

    it("should return a random uuid with '-l' flag", function()
        for _ = 1, 50 do
            local success, random_uuid = pcall(uuid.normal_random_uuid, {
                "-l",
            })
            assert.is_true(success)
            assert.same(type(random_uuid), "string")
            local match = random_uuid:match(uuid_l_pattern)
            assert.is_truthy(match)
        end
    end)

    it("should return a random uuid with '--lowercase' flag", function()
        for _ = 1, 50 do
            local success, random_uuid = pcall(uuid.normal_random_uuid, {
                "--lowercase",
            })
            assert.is_true(success)
            assert.same(type(random_uuid), "string")
            local match = random_uuid:match(uuid_l_pattern)
            assert.is_truthy(match)
        end
    end)

    it("should error when called with '-l' flag and a value", function()
        local success, error = pcall(uuid.normal_random_uuid, {
            "-l",
            "dummy",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "flag 'lowercase' is boolean and does not expect a value"))
    end)

    it("should error when called with unknown '-q' flag", function()
        local success, error = pcall(uuid.normal_random_uuid, {
            "-f",
            "-q",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'q'"))
    end)

    it("should error when called with unknown '--quiet' flag", function()
        local success, error = pcall(uuid.normal_random_uuid, {
            "--lowercase",
            "--quiet",
        })
        assert.is_false(success)
        assert.is_truthy(string.find(error, "unknown flag passed 'quiet'"))
    end)
end)
