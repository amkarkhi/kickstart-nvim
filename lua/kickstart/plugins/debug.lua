return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_setup = true,
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
                'delve',
            },
        }

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        dapui.setup {
            render = {
                indent = 2,
            },
            layouts = {},
            config = {},
            force_buffers = false,
            element_mappings = {},
            mappings = {
                expand = { '<CR>', '<2-LeftMouse>' },
                open = 'o',
                remove = 'd',
                edit = 'e',
            },
            sidebar = {
                open_on_start = true,
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = 'scopes',
                        size = 0.25, -- Can be float or integer > 1
                    },
                    {
                        id = 'breakpoints',
                        size = 0.25,
                    },
                    { id = 'stacks', size = 0.25 },
                    { id = 'watches', size = 00.25 },
                },
            },
            tray = {
                open_on_start = true,
                elements = { 'repl' },
            },
            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = '',
                mappings = {},
            },
            windows = { indent = 1 },

            expand_lines = true,
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                enabled = true,
                element = '',
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup()
    end,
}
