# randiverse.nvim
Tired of raking your brain trying to generate 'random' inputs to test/sample cases (and secretly leaking your life details :laugh:)! Try out the Random Universe to create & input necessary random strings.

Work in progress!
```bash
nvim --headless --noplugin -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal_init.lua'}"
```

-- TODO: Refactor below functions in separate Lua modules to handle args & processing
- int
- float
- name 
- country
- letter 
- letter and number
- word
- text
- lorem
- uuid 
- url
- email
- hex 
- date 
- time
- phone
- ipv4
- ipv6

-- CORE USE CASES:


looking for eyes on:
- Randiverse command calling options (keymaps + does it make sense to have UNIVERSAL randiverse with passed 'secondary' commands?)
- math.randomseed location
- opening files and their paths
- correctly passing errors to nvim so it is displayed
- where should cursor be placed after insert?? (before or after inserted)
- flag to add "" around the inserted?
- flags for each of the potential commands + structure of passing flags (-flag=xx or -flag xx or etc.)
- keymaps for the essential default commands?
- method of exposing Randiverse API make sense?
- better to have text files or just a function return long list of items to select random?
- how to handle ability to get a random item where it starts with a letter? (text, in-memory table, split files, etc.) 
- IK how to make it downloadable for Lazy... but how and which other managers should I consider and setting up infra for that..
- I liked this over Luasnips because Luasnips were either static or required input every time or then separate snippets for each functionality/random attribute you may want to add.
- Liked being able to consolidate it under one command that can be called (like Sublime/VScode) and ability to create keymaps for them and user defined commands that run for Randiverse
- Or, if you wanted to build a fully dymamic Luasnip like mine have it either requires prompting it every time with values for flags you don't care about to get what you want...

Inspirations/Related Work:
- [Random Everything VSCode Plugin](https://github.com/helixquar/randomeverything) --> Original inspiration (a VSCode convert :smile:)
- [Random Text Sublime Plugin](https://github.com/kimpettersen/random-sublime-text-plugin) -> Original inspiration for VSCode plugin
- [Lorem Ipsum Generator](https://github.com/derektata/lorem.nvim) --> Inspiration for writing a Lorem Ipsum gtext generator
- [nvim-surround] --> General inspiration for writing nvim plugins
