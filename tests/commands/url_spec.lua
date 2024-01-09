local config = require("randiverse.config")
local url = require("randiverse.commands.url")
local utils = require("randiverse.commands.utils")

local test_utils = require("tests.utils")

describe("Randiverse 'url' command", function()
    it("should return random url with no flags", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {})
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)$")
            assert.is_truthy(protocol and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--subdomains 1'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--subdomains",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, subdomain, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)%.(%l+)$")
            assert.is_truthy(protocol and subdomain and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    subdomain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--subdomains 3'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--subdomains",
                "3",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, s1, s2, s3, domain, tld = random_url:match("^(%l+)://(%l+)%.(%l+)%.(%l+)%.(%l+)%.(%l+)$")
            assert.is_truthy(protocol and s1 and s2 and s3 and domain and tld)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s2
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_subdomain_corpus]
                    ),
                    s3
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
        end
    end)

    it("should return random url with '--paths 1'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "1",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, path = random_url:match("^(%l+)://(%l+)%.(%l+)/(%l+)$")
            assert.is_truthy(protocol and domain and tld and path)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    path
                )
            )
        end
    end)

    it("should return random url with '--paths 2'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--paths",
                "2",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, p1, p2 = random_url:match("^(%l+)://(%l+)%.(%l+)/(%l+)/(%l+)$")
            assert.is_truthy(protocol and domain and tld and p1 and p2)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p1
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_path_corpus]
                    ),
                    p2
                )
            )
        end
    end)

    it("should return random url with '--fragment'", function()
        for _ = 1, 20 do
            local success, random_url = pcall(url.normal_random_url, {
                "--fragment",
            })
            assert.is_true(success)
            assert.same(type(random_url), "string")
            local protocol, domain, tld, fragment = random_url:match("^(%l+)://(%l+)%.(%l+)#(%l+)$")
            assert.is_truthy(protocol and domain and tld and fragment)
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.protocols, protocol))
            assert.is_true(test_utils.list_contains(config.user_opts.data.url.tlds, tld))
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_domain_corpus]
                    ),
                    domain
                )
            )
            assert.is_true(
                test_utils.list_contains(
                    utils.read_lines(
                        config.user_opts.data.ROOT
                            .. config.user_opts.data.word.corpuses[config.user_opts.data.url.default_fragment_corpus]
                    ),
                    fragment
                )
            )
        end
    end)
end)
