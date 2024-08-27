return {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/neotest-go',
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        -- get neotest namespace (api call creates or returns namespace)
        local neotest_ns = vim.api.nvim_create_namespace 'neotest'
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
                    return message
                end,
            },
        }, neotest_ns)

        -- add a neovim command to run tests in the current file
        local function run_tests()
            require('neotest').run.run()
        end
        local function run_test_file()
            require('neotest').run.run(vim.fn.expand '%')
        end
        local function run_test_directory()
            require('neotest').run.run '${workspaceFolder}'
        end

        -- register these functions
        vim.api.nvim_create_user_command('NeotestRun', run_tests, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestRunFile', run_test_file, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestRunDirectory', run_test_directory, { nargs = 0 })

        require('neotest').setup {
            adapters = {
                -- require 'neotest-golang', -- Registration
                require 'neotest-go', -- Registration
            },
            run = {
                enabled = true,
                neotest = {
                    command = 'neotest',
                    args = { '--log-level', '2' },
                },
            },
            discovery = {
                enabled = true,
                go = {
                    command = 'go',
                    args = { 'list', './...' },
                    cwd = '${workspaceFolder}',
                },
            },
            log_level = 2,
            output = {
                border = true,
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                enabled = true,
                open_on_run = true,
            },
            watch = {
                enabled = true,
                symbol_queries = { 'test', 'example' },
                patterns = { '*.go' },
            },
            statusline = {
                enable = true,
                interval = 1000,
                format = 'Neotest: %',
            },
            output_panel = {
                enabled = true,
                open = 'belowright 10new',
                position = 'bottom',
                size = 10,
                border = true,
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            },
        }
    end,
}
