-- OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.bo.filetype == "lua" then
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
    else
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
    end
  end,
})

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.list = true
vim.opt.listchars = {
  space = "·", -- interpunct symbol
  tab = "-->",
}

vim.opt.signcolumn = "no" -- prevents page from shifting from signs on left

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

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
  "https://github.com/saghen/blink.cmp",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/windwp/nvim-autopairs",
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

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

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
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
  fuzzy = { implementation = "lua" },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true },
})

require("nvim-autopairs").setup()

vim.cmd.colorscheme("catppuccin-mocha")
