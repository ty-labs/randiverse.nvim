local current_dir = vim.fn.getcwd()
local plenary_dir = current_dir .. "/../plenary.nvim"

vim.o.runtimepath = current_dir .. "," .. vim.o.runtimepath
vim.o.runtimepath = plenary_dir .. "," .. vim.o.runtimepath

vim.cmd("runtime! plugin/plenary.vim")
require("randiverse").setup()
