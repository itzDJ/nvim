-- (VIM) SETTINGS
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable netrw banner
vim.g.netrw_banner = 0

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Spell checking
-- NOTE: Manually use `:set spell` and `:set nospell` as needed
-- vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Rendering whitespaces
vim.opt.list = true
vim.opt.listchars = {
    space = "·", -- interpunct symbol
    tab = "-->", -- two dashes and a greater than symbol
}

-- Removes weird gray column on the left in default macOS terminal
vim.opt.signcolumn = "no"

-- 7 lines max show up in CMP's completion menu
vim.opt.pumheight = 7

-- Case insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Override ignorecase if the search pattern contains uppercase characters

-- Enable truecolor support
vim.opt.termguicolors = true

-- Remove the default popup-menu (on right click) without disabling mouse
vim.cmd([[
    aunmenu PopUp
    autocmd! nvim.popupmenu
]])
