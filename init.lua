-- OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.netrw_banner = 0
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "-->" }
vim.opt.signcolumn = "no"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

-- AUTOCMDS
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.bo.expandtab = true
    if vim.bo.filetype == "lua" then
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
    else
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
    end
  end,
})
vim.cmd([[
  aunmenu PopUp
  autocmd! nvim.popupmenu
]])

-- KEYMAPS
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>t", ":Explore<CR>")
-- move lines down or up
vim.keymap.set("n", "<c-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<c-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")
-- yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- PLUGINS
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/stevearc/conform.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1" },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/windwp/nvim-autopairs",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

vim.cmd.colorscheme("catppuccin-mocha")
vim.diagnostic.config({ virtual_text = true })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "stylua",
    "pyright",
    "black",
    "isort",
  },
})
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
  },
  formatters = {
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
require("blink.cmp").setup({
  completion = {
    menu = { max_height = 5 },
  },
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
require("nvim-autopairs").setup()
