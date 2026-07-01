return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    enable = true,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        lazygit = { enabled = false },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        image = {},
    },
    config = function(_, opts)
        require('snacks').setup(opts)
        vim.ui.input = require 'snacks.input'
        vim.ui.select = require 'snacks.picker.select'
    end,
}
