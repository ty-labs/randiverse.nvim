# randiverse.nvim
Tired of raking your brain trying to generate 'random' inputs to test/sample cases (and secretly leaking your life details :laugh:)! Try out the Random Universe to create & input necessary random strings.

Work in progress!
```bash
nvim --headless --noplugin -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal_init.lua'}"
```

looking for eyes on:
- math.randomseed location
- opening files and their paths
- correctly passing errors to nvim so it is displayed
- where should cursor be placed after insert?? (before or after inserted)
- flag to add "" around the inserted?
- flags for each of the potential commands + structure of passing flags (-flag=xx or -flag xx or etc.)
- keymaps for the essential default commands?
