return {
    'nvim-tree/nvim-tree.lua',
    opts = {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        renderer = {
            root_folder_modifier = ':t',
            icons = {
                glyphs = {
                    default = '',
                    symlink = '',
                    folder = {
                        arrow_open = '',
                        arrow_closed = '',
                        default = '',
                        open = '',
                        empty = '',
                        empty_open = '',
                        symlink = '',
                        symlink_open = '',
                    },
                    git = {
                        unstaged = '✗',
                        staged = '✓',
                        unmerged = '',
                        renamed = '➜',
                        untracked = '★',
                        deleted = '',
                        ignored = '◌',
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = '',
                info = '',
                warning = '',
                error = '',
            },
        },
        view = {
            width = 30,
            side = 'left',
        },
    },
}

--       mappings = {
--         list = {
-- -- { key = { 'l', '<CR>', 'o' }, cb = tree_cb 'edit' },
-- -- { key = 'h', cb = tree_cb 'close_node' },
-- -- { key = 'v', cb = tree_cb 'vsplit' },
--
-- },
--       },
