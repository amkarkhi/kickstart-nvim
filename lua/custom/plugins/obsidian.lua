return {
    'epwalsh/obsidian.nvim',
    -- version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            {
                name = 'work',
                path = '~/project/notes/',
            },
            -- {
            --     name = 'home',
            --     path = '~/projects/notes/',
            -- },
        },
        ui = {
            enable = true,
            checkboxes = {
                [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
                ['x'] = { char = '', hl_group = 'ObsidianDone' },
                ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
                ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
                ['!'] = { char = '', hl_group = 'ObsidianImportant' },
                -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
            },
            bullets = { char = '•', hl_group = 'ObsidianBullet' },
            external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
            reference_text = { hl_group = 'ObsidianRefText' },
            highlight_text = { hl_group = 'ObsidianHighlightText' },
            tags = { hl_group = 'ObsidianTag' },
            block_ids = { hl_group = 'ObsidianBlockID' },
            hl_groups = {
                -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                ObsidianTodo = { bold = true, fg = '#f78c6c' },
                ObsidianDone = { bold = true, fg = '#89ddff' },
                ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
                ObsidianTilde = { bold = true, fg = '#ff5370' },
                ObsidianImportant = { bold = true, fg = '#d73128' },
                ObsidianBullet = { bold = true, fg = '#89ddff' },
                ObsidianRefText = { underline = true, fg = '#c792ea' },
                ObsidianExtLinkIcon = { fg = '#c792ea' },
                ObsidianTag = { italic = true, fg = '#89ddff' },
                ObsidianBlockID = { italic = true, fg = '#89ddff' },
                ObsidianHighlightText = { bg = '#75662e' },
            },
        },
    },
}
