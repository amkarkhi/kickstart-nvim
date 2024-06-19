local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            transparent_background = true,
            style = 'hard',
        },
    },
    {
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        init = function()
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'tokyonight-storm'
            vim.cmd.hi 'Comment gui=none'
        end,
        opts = {
            transparent_background = true,
            transparent = true,
            sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'spectre_panel', 'fern', 'NvimTree', 'Outline' },
            darkSidebar = true,
            darkFloat = true,
            border = 'single',
            terminal_colors = true,
            hide_inactive_statusline = true,
            dim_inactive = true,
            lualine_bold = true,
            night_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        },
    },
    { import = 'custom.plugins' },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- put them in the right spots if you want.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
    --
    --  Here are some example plugins that I've included in the kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    require 'kickstart.plugins.indent_line',
}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = ' ',
            ft = ' ',
            init = '⚙',
            keys = '🗝',
            plugin = ' ',
            runtime = ' ',
            require = ' ',
            source = ' ',
            start = ' ',
            task = ' ',
            lazy = ' ',
        },
    },
})
