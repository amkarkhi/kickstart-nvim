return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {},
    init = function() -- This is the function that runs, BEFORE loading
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    keys = {
        { '<leader>W', group = '[W]orkspace' },
        { '<leader>W_', hidden = true },
        { '<leader>a', group = '[A]I' },
        { '<leader>a_', hidden = true },
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>g', group = '[G]it' },
        { '<leader>g_', hidden = true },
        { '<leader>gd', group = '[G]it [D]iff' },
        { '<leader>gd_', hidden = true },
        { '<leader>m', group = '[M]ark Harpoon' },
        { '<leader>m_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
    },
    config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup {
            triggers_blacklist = {
                i = { 'j', 'k', '<leader>' },
            },
        }
    end,
}
