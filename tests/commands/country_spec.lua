local country = require("randiverse.commands.country")

describe("Randiverse 'country' command", function()
    it("should return a random country with no flags", function()
        local success, random_country = pcall(country.normal_random_country, {})
        assert.is_true(success)
        assert.is_true(random_country:gsub("[^%a]", ""):len() >= 4)
        -- assert it is in the list of countries
    end)

    it("should return a random country code with '-c 2' flag", function()
        local random_country = country.normal_random_country({
            "-c",
            "2",
        })
        assert.is_true(random_country:gsub("[^%u]", ""):len() == 2)
    end)

    it("should return a random country code with '-c alpha-2' flag", function()
        local random_country = country.normal_random_country({
            "-c",
            "alpha-2",
        })
        assert.is_true(random_country:gsub("[^%u]", ""):len() == 2)
    end)

    it("should return a random country code with '-c 3' flag", function()
        local random_country = country.normal_random_country({
            "-c",
            "3",
        })
        assert.is_true(random_country:gsub("[^%u]", ""):len() == 3)
    end)

    it("should return a random country code with '-c alpha-3' flag", function()
        local random_country = country.normal_random_country({
            "-c",
            "alpha-3",
        })
        assert.is_true(random_country:gsub("[^%u]", ""):len() == 3)
    end)

    it("should return a random country code with '-c alpha-3' flag", function()
        local random_country = country.normal_random_country({
            "-c",
            "alpha-3",
        })
        assert.is_true(random_country:gsub("[^%u]", ""):len() == 3)
    end)

    it("should return a random country numeric code with '-n' flag", function()
        local random_country = country.normal_random_country({
            "-n",
        })
        assert.is_true(string.match(random_country, "^%d%d%d$") ~= nil)
    end)
end)
