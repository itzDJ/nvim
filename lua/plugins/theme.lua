return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
        -- If `echo $COLORTERM` returns 'truecolor\n' then enable truecolor and the theme
        if io.popen("echo $COLORTERM"):read("*a") == "truecolor\n" then
            vim.opt.termguicolors = true
            vim.cmd("colorscheme github_dark")
        end
    end,
}
