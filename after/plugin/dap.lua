local dap = require 'dap'
local dapui = require 'dapui'
local dapgo = require 'dap-go'

dapgo.setup {}

dap.set_log_level 'TRACE'
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = 'brakpointhl', numhl = 'brakpointhl' })
vim.fn.sign_define('DapBreakpointCondition', { text = '●?', texthl = '', linehl = 'brakpointhl', numhl = 'brakpointhl' })
vim.fn.sign_define('DapLogPoint', { text = '➜', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '■', texthl = '', linehl = 'debugCurrent', numhl = 'debugCurrent' })
vim.fn.sign_define('DapBreakpointRejected', { text = '●✖', texthl = '', linehl = 'debugError', numhl = 'debugError' })

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb',
    name = 'lldb',
}

dap.configurations.cpp = {
    {
        name = 'launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input { 'Path to executable: ', vim.fn.getcwd() .. '/', 'file' }
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}

-- dap.configurations.rust = {
--     {
--         name = 'Launch file',
--         type = 'lldb',
--         request = 'launch',
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--     },
--     {
--         name = 'debug',
--         type = 'lldb',
--         request = 'launch',
--         program = function()
--             local project = vim.fn.fnamemodify(cwd, ':t')
--             return vim.fn.getcwd() .. '/target/debug/' .. project
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--     },
-- }

dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}

dap.configurations.c = {
    {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = 'Select and attach to process',
        type = 'gdb',
        request = 'attach',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input 'Executable name (filter): '
            return require('dap.utils').pick_process { filter = name }
        end,
        cwd = '${workspaceFolder}',
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
    },
}

dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
    {
        name = 'Launch Project',
        type = 'lldb',
        request = 'launch',
        program = function()
            local project = vim.fn.fnamemodify(cwd, ':t')
            return vim.fn.getcwd() .. '/target/debug/' .. project
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = 'Select and attach to process',
        type = 'lldb',
        request = 'attach',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input 'Executable name (filter): '
            return require('dap.utils').pick_process { filter = name }
        end,
        cwd = '${workspaceFolder}',
    },
}

dapui.setup {
    controls = {
        element = 'repl',
        enabled = true,
        icons = {
            disconnect = '',
            pause = '',
            play = '',
            run_last = '',
            step_back = '',
            step_into = '',
            step_out = '',
            step_over = '',
            terminate = '',
        },
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = 'single',
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    force_buffers = true,
    icons = {
        collapsed = '',
        current_frame = '',
        expanded = '',
    },
    layouts = {
        {
            elements = {
                {
                    id = 'scopes',
                    size = 0.25,
                },
                {
                    id = 'breakpoints',
                    size = 0.25,
                },
                {
                    id = 'stacks',
                    size = 0.25,
                },
                {
                    id = 'watches',
                    size = 0.25,
                },
            },
            position = 'left',
            size = 40,
        },
        {
            elements = {
                {
                    id = 'repl',
                    size = 0.5,
                },
                {
                    id = 'console',
                    size = 0.5,
                },
            },
            position = 'bottom',
            size = 10,
        },
    },
    mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
    },
    render = {
        indent = 1,
        max_value_lines = 100,
    },
}

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

local keymap = vim.keymap.set
local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

vim.api.nvim_create_user_command('ToggleDapUI', dapui.toggle, {})

keymap('n', '<F6>', dap.close, opts 'Debug: Stop')
keymap('n', '<F5>', dap.continue, opts 'Debug: Continue')
keymap('n', '<leader>dn', dap.step_over, opts 'Debug: Step Over')
keymap('n', '<leader>di', dap.step_into, opts 'Debug: Step Into')
keymap('n', '<leader>do', dap.step_out, opts 'Debug: Step Out')
keymap('n', '<leader>db', dap.toggle_breakpoint, opts 'Debug: Toggle Breakpoint')
keymap('n', '<leader>dc', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, opts 'Debug: Set Breakpoint')
keymap('n', '<leader>dr', dap.repl.open, opts 'Debug: Open REPL')
keymap('n', '<leader>dp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input 'log point message: ')
end, opts 'Debug: Log Point')
