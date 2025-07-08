-- return {
--     'github/copilot.vim',
--     { 'ofseed/copilot-status.nvim' },
-- }

return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup {
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = '[[',
                    jump_next = ']]',
                    accept = '<Tab>',
                    refresh = 'gr',
                    open = '<M-CR>',
                },
                layout = {
                    position = 'bottom', -- | top | left | right | horizontal | vertical
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                debounce = 75,
                trigger_on_accept = true,
                keymap = {
                    accept = '<Tab>',
                    accept_word = false,
                    accept_line = '<C-Tab>',
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '<C-e>',
                },
            },
            filetypes = {
                ['*'] = true,
            },
            auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
            copilot_node_command = 'node', -- Node.js version must be > 20
            -- workspace_folders = {},
            -- copilot_model = '',
            root_dir = function()
                return vim.fs.dirname(vim.fs.find('.git', { upward = true })[1])
            end,
            should_attach = function(_, _)
                if not vim.bo.buflisted then
                    return true
                end
                if vim.bo.buftype ~= '' then
                    return false
                end
                return true
            end,
            server = {
                type = 'nodejs',
                custom_server_filepath = nil,
            },
            server_opts_overrides = {},
        }
    end,
}
