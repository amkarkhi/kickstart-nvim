return {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = true,

        --TODO: This is a comment
        --FIXME:
        highlight = {
            before = 'fg',
            -- keyword = 'fg',
            after = 'fg',
            pattern = [[.*<(KEYWORDS)\s*:]],
        },
        keywords = {
            FIX = {
                icon = '',
                color = 'error',
                alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
                highlight = 'error',
            },
            TODO = {
                icon = '',
                color = 'info',
                alt = { 'NOTE', 'TODO' },
                highlight = 'info',
            },
            HACK = {
                icon = '',
                color = 'warning',
                alt = { 'WARNING', 'CAUTION', 'HACK' },
                highlight = 'warning',
            },
            WARN = {
                icon = '',
                color = 'warning',
                alt = { 'WARNING', 'XXX' },
                highlight = 'warning',
            },
        },
    },
}
