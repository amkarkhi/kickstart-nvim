return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    init = function() -- This is the function that runs, BEFORE loading
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function() -- This is the function that runs, AFTER loading
        require('which-key').setup {
            triggers_blacklist = {
                i = { 'j', 'k', '<leader>' },
            },
        }
        -- Document existing key chains
        require('which-key').register {
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>W'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
            ['<leader>a'] = { name = '[A]I', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
            ['<leader>gd'] = { name = '[G]it [D]iff', _ = 'which_key_ignore' },
            ['<leader>m'] = { name = '[M]ark Harpoon', _ = 'which_key_ignore' },
        }
    end,
}
