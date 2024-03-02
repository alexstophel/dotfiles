-- Turn off swap files
vim.o.swapfile = false

-- Set leader
vim.g.mapleader = " "

-- Quicker window movement
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- Softtabs, 2 spaces
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

-- Show the ruler
vim.o.ruler = true
vim.o.textwidth = 80
vim.o.colorcolumn = "+1"

-- Show lines numbers
vim.wo.number = true
vim.wo.numberwidth = 5

-- Allow the dot command in all modes
vim.api.nvim_set_keymap('x', '.', ':norm.<CR>', {noremap = true})

-- Set `jk` mapping for ESC
vim.o.timeoutlen = 350
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {})

-- Tab completion
vim.o.wildmode = "list:longest,list:full"
vim.api.nvim_exec([[
  function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
  endfunction
  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <S-Tab> <c-n>
]], false)

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Configure lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>nt', ":NERDTree<CR>", { noremap = true })

vim.cmd[[colorscheme solarized-osaka]]

require("mason").setup()
require("mason-lspconfig").setup()

vim.g.ale_enable = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_linters = { go = {'golangci-lint'} }
vim.g.ale_fixers = { go = {'gofmt', 'gofumpt', 'goimports', 'golines', 'gopls'} }
