return {
    'nvim-neotest/neotest',
    dependencies = {
        -- 'nvim-neotest/neotest-go',
        { 'fredrikaverpil/neotest-golang', version = '*' }, -- Installation
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
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
            local n = require 'neotest'
            n.output_panel.clear()
            n.run.run()
            n.output_panel.open()
        end
        local function run_test_file()
            require('neotest').run.run(vim.fn.expand '%')
        end
        local function run_my_file()
            require('neotest').run.run(vim.fn.getcwd())
        end
        local function run_test_directory()
            require('neotest').run.run '${workspaceFolder}'
        end
        local function run_test_summary()
            require('neotest').summary '${workspaceFolder}'
        end

        local function run_test_clear_output()
            require('neotest').output_panel.clear()
        end

        -- register these functions
        vim.api.nvim_create_user_command('NeotestRun', run_tests, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestRunFile', run_test_file, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestRunDirectory', run_test_directory, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestHere', run_my_file, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestSummary', run_test_summary, { nargs = 0 })
        vim.api.nvim_create_user_command('NeotestClear', run_test_clear_output, { nargs = 0 })

        require('neotest').setup {
            state = { enabled = true },
            diagnostic = {
                enabled = true,
                severity = 0,
            },
            floating = {
                options = {},
                enabled = true,
                border = 'rounded',
                max_height = 0.8,
                max_width = 0.8,
                position = 'right',
            },
            level = vim.log.levels.DEBUG,
            adapters = {
                -- require 'neotest-go', -- Registration
                require 'rustaceanvim.neotest',
                require 'neotest-golang'(neotest_golang_opts), -- Registration
            },
            status = {
                enabled = true,
                signs = true,
                virtual_text = true,
            },
            icons = {
                enabled = true,
                success = '✓',
                error = '✗',
            },
            quickfix = {
                auto_open = true,
                auto_close = true,
                enabled = true,
                open = true,
            },
            summary = {
                enabled = true,
                follow = true,
                animated = true,
                open = 'belowright 10new',
                count = true,
                expand_errors = true,
                border = true,
                mappings = {
                    expand = 'e',
                    jump = 'j',
                    jump_prev = 'k',
                    jump_next = 'l',
                    run = 'r',
                    clear_target = 'c',
                    clear_marked = 'm',
                    short = 's',
                    watch = 'w',
                },
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
                concurrent = 1,
                go = {
                    command = 'go',
                    args = { 'list', './...' },
                    cwd = '${workspaceFolder}',
                },
                -- rust = {
                --     command = 'cargo',
                --     args = { 'test' },
                --     cwd = '${workspaceFolder}',
                -- },
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
                debounce = 1000,
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
