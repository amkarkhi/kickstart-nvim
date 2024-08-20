local dap = require 'dap'
local dapui = require 'dapui'

-- create breakpointhl group with custom color redish background

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = 'brakpointhl', numhl = 'brakpointhl' })
vim.fn.sign_define('DapBreakpointCondition', { text = '●?', texthl = '', linehl = 'brakpointhl', numhl = 'brakpointhl' })
vim.fn.sign_define('DapLogPoint', { text = '➜', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '■', texthl = '', linehl = 'debugCurrent', numhl = 'debugCurrent' })
vim.fn.sign_define('DapBreakpointRejected', { text = '●✖', texthl = '', linehl = 'debugError', numhl = 'debugError' })

dap.adapters.delve = {
    type = 'server',
    port = '4000',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:4000' },
    },
}

dap.configurations.lldb = {
    type = 'executable',
    command = 'lldb-vscode',
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

dap.configurations.go = {
    {
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'delve',
        name = 'run main',
        request = 'launch',
        program = '${workspaceFolder}',
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
