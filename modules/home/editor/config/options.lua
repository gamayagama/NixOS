-- Variables --
local opt = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo
local cmd = vim.cmd

-- Set leader key
g.mapleader = ' '
g.maplocalleader = ' '

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- General QOL settings
opt.showmode = false
opt.swapfile = false
opt.undofile = true
opt.timeoutlen = 300
o.updatetime = 50
o.termguicolors = true
o.mouse = 'a'
o.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 10
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Number column
opt.number = true
opt.relativenumber = true

-- Case sensitivity
opt.ignorecase = true
opt.smartcase = true

-- Indentation behaviour
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0

-- Window split behaviour
opt.splitright = true
opt.splitbelow = true

-- Display whitespace characters
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Disable word wrap
wo.wrap = false

-- Search settings
opt.hlsearch = false
opt.incsearch = true

-- Preview substitutions
opt.inccommand = 'split'
