# randiverse.nvim💥

Tired of raking your brain trying to generate 'random' text for sample/test cases (and secretly leaking your life details😆)?? Randiverse—the "Random Universe"—is a flexible, configurable nvim plugin that can generate random text for a variety of scenarios including ints, floats, names, dates, lorem ipsum, emails, and more! Created by a recent VScode --> NVIM convert and inspired by the simple, albeit handy, "Random Everything" VScode extension.

**Insert Demo Video Clip Here**

Author: [Tyler Lowe](https://github.com/ty-labs)

License: [MIT License](https://github.com/ty-labs/randiverse.nvim/blob/main/LICENSE)

# Requirements🔒

randiverse.nvim was built w/ minimal dependencies using standard Lua and Neovim:

- [Neovim 0.8+](https://github.com/neovim/neovim/releases)
- [Lua 5.1.5+]()

# Installation📦

Install randiverse.nvim using your favorite plugin manager, then call `require("randiverse").setup()`

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "ty-labs/randiverse.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("randiverse").setup({
            -- Custom configurations here, or leave empty to use defaults
        })
    end
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({
    "ty-labs/randiverse.nvim",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("randiverse").setup({
            -- Custom configuration here, or leave empty to use defaults
        })
    end
})
```

# Usage💻

## The Basics

Generally, the plugin functionality is accessed via the registered editor command 'Randiverse'. The editor command 'Randiverse' also requires a command (int, float, name, etc.) with possible command flags which tell Randiverse what random text to generate. Note that both 'Randiverse' and its commands have auto-completion as demonstrated below. The Randiverse access pattern will look like the following:

`:Randiverse <command> <optional command flags>`

**Insert Demo Video**

Command flags can either be short or long hand but are inputted as `flag value` NOT `flag=value`. Each Randiverse command also comes with a default keymap that is prefixed by `<leader>r...` and maps to the default random text generation for the command. 

## int

`:Randiverse int <optional int flags>`

Picks a random integer from within a range. The default range is 1-100.

| Flag      | Description |
| :---        |    :----   |
| -s/--start start      | set the start for the range (integer).       |
| -l/--last    | set the stop for the range (integer).        |

Default Keymap: `<leader>ri`

Configurations: 

## float

`:Randiverse float <optional float flags>`

Picks a random float from within a range. The default range is 1-100 w/ float having two decimals.

| Flag      | Description |
| :---        |    :----   |
| -s/--start start      | set the start for the range (integer).       |
| -l/--last    | set the stop for the range (integer).        |
| -d/--decimals | set the # of decimals in the output (non-negative integer). |

Default Keymap: `<leader>rf`

Configurations: 

## name

`:Randiverse name <optional name flags>`

Selects a random name. The default is a full name (first and last) unless flags are set.

| Flag      | Description |
| :---        |    :----   |
| -f/--first      | return a random first name       |
| -l/--last    | return a random last name        |

Default Keymap: `<leader>rn`

## word

Dummy Text

## lorem

Dummy Text

## country

Dummy Text

## datetime

Dummy Text

## email

Dummy Text

## url

Dummy Text

## uuid

Dummy Text

## ip

Dummy Text

## hexcolor

Dummy Text

# Configuration🏗️

Dummy Text

# Contributing✍️

Dummy Text

# Shoutouts📢

- [Random Everything](https://github.com/helixquar/randomeverything)         --> Original inspiration as a revamped version of the VScode extension.
- [Random Text](https://github.com/kimpettersen/random-sublime-text-plugin)  --> Sublime random text generator which Random Everything was based on.
- [Lorem Ipsum Generator](https://github.com/derektata/lorem.nvim)           --> Inspiration for building the Lorem Ipsum generator feature.
- [nvim-surround](https://github.com/kylechui/nvim-surround/tree/main)       --> General structure for writing nvim plugins.
- If you like this project consider giving a [star⭐](https://github.com/ty-labs/randiverse.nvim/tree/main) to show your support!
