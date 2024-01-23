# randiverse.nvim💥

Tired of raking your brain trying to generate 'random' text for sample/test cases (and secretly leaking your life details😆)?? Randiverse—the "Random Universe"—is a flexible, configurable nvim plugin that can generate random text for a variety of scenarios including ints, floats, names, dates, lorem ipsum, emails, and more! Created by a recent VScode —> NVIM convert and inspired by the simple, albeit handy, "Random Everything" VScode extension.

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

**Insert Demo Video (opening and auto-completion features...)**

Command flags can either be short or long hand but are inputted as `flag value` NOT `flag=value` or simply boolean flag. Each Randiverse command also comes with a default keymap that is prefixed by `<leader>r...` and maps to the default random text generation for the command. 

## int

`:Randiverse int <optional int flags>`

Picks a random int from within a range. The default range is \[1-100\].

| Flag | Description | Value |
|:-----|:------------|:------|
| `-s/--start start` | Set the start for the range. <br/>Example: '`-s 50`' would change the range to \[50-100\]. | Integer |
| `-l/--stop stop` | Set the stop for the range. <br/>Example: '`-S 70`' would change the range to \[0-70\]. | Integer |

Default Keymap: `<leader>ri`

**Insert Demo Video**

Configurations:

```lua
{
    data: {
        int: {
            default_start = <int>, --Configuration here, or leave empty to use default (1)
            default_stop = <int>, --Configuration here, or leave empty to use default (100)
        }
    }
}
```

## float

`:Randiverse float <optional float flags>`

Picks a random float from within a range. The default range is \[1-100\] w/ the output having two decimal places.

| Flag | Description | Value |
|:-----|:------------|:------|
| `-s/--start start` | Set the start for the range. <br/>Example: '`-s 50`' would change the range to \[50-100\]. | Integer |
| `-l/--stop stop` | Set the stop for the range. <br/>Example: '`-S 70`' would change the range to \[0-70\]. | Integer |
| `-d/--decimals decimals` | Set the # of decimal places in the output. <br/>Example: '`-d 4`' would change output to `xx.xxxx`. | Non-negative Integer |

Default Keymap: `<leader>rf`

**Insert Demo Video**

Configurations:

```lua
{
    data: {
        int: {
            default_start = <int>, --Configuration here, or leave empty to use default (1)
            default_stop = <int>, --Configuration here, or leave empty to use default (100)
            default_decimals = <int>, -- Configuration here, or leave empty to use default (2)
        }
    }
}
```

## name

`:Randiverse name <optional name flags>`

Generates a random name. The default is a full name (first and last) unless flags are set. The random name is generated via random selection from a static first + last name corpus that Randiverse comes bundled with.

| Flag | Description | Value |
|:-----|:------------|:------|
| `-f/--first` | Return the first name component. <br/>Example: '`-f` would toggle the output to include a first name (plus any other toggled components). | None |
| `-l/--last` | Return the last name component. <br/>Example: '`-l`' would toggle the output to include a last name (plus any other toggled components). | None |

Default Keymap: `<leader>rn`

**Insert Demo Video**

Configurations:

```lua
{
    data: {
        name: {
            FIRST = <file_path>, --Configuration here, or leave empty to use default (included 'names_first.txt')
            LAST = <file_path>, --Configuration here, or leave empty to use default (included 'names_last.txt')
        }
    }
}
```

## word

`:Randiverse word <optional word flags>`

Generates a random word(s). The default number of returned random words is 1. The random words are generated via random selection from a corpus. Corpuses are configured in the `data.word.corpuses` map which maps (corpus name —> corpus relative path from the `data.ROOT`). By default, Randiverse comes bundled and configured with a 'short', 'medium', and 'long' corpuses available; 'medium' is the default corpus for random word generation.

| Flag | Description | Value |
|:-----|:------------|:------|
| `-a/--all`| Use all of the configured corpuses to select a random word. <br/>Example: '`-a`' would toggle output s.t. `<word>` could be from 'short', 'medium', or 'long' corpus. | None |
| `-c/--corpus corpus`   | Set the corpus from configured corpuses to select random word from. <br/>Example: '`-c long`' would change output `<word>` to be from 'long' corpus. | String; Key in '`data.word.corpuses`' map. |
| `-l/--length length`  | Set the # of words to return (separated by spaces). <br/>Example: '`-l 3`' would change output to `<word> <word> <word>` where words are from the default corpus. | Positive Integer |

Default Keymap: `<leader>rn`

**Insert Demo Video**

Configurations:

```lua
{
    data: {
        word: {
            corpuses = {
                -- Configuration here, or leave empty to use default
            },
            default_corpus = <key_in_corpuses>, --Configuration here, or leave empty to use default (included 'medium')
            default_length = <int>, --Configuration here, or leave empty to use default (1)
        }
    }
}
```

## lorem

Dummy TExamplet

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

I'm always looking for new random text commands to add as well as more flags and enhancements. Feel free to mark an issue or try handling it yourself!

# Shoutouts📢

- [Random Everything](https://github.com/helixquar/randomeverything)         —> Original inspiration as a revamped version of the VScode extension.
- [Random Text](https://github.com/kimpettersen/random-sublime-text-plugin)  —> Sublime random text generator which Random Everything was based on.
- [Lorem Ipsum Generator](https://github.com/derektata/lorem.nvim)           —> Inspiration for building the Lorem Ipsum generator feature.
- [nvim-surround](https://github.com/kylechui/nvim-surround/tree/main)       —> General structure for writing nvim plugins.
- If you like this project consider a [star⭐](https://github.com/ty-labs/randiverse.nvim/tree/main) to show your support!
