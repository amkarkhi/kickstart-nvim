local dap = require 'dap'
local dapui = require 'dapui'

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

require('dap-go').setup {
    -- :help dap-configuration
    dap_configurations = {
        {
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
        },
    },
    delve = {
        path = 'dlv',
        initialize_timeout_sec = 20,
        port = '${port}',
        args = {},
        build_flags = '',
    },
}

dapui.setup {
    icons = {
        expanded = '▾',
        collapsed = '▸',
        circular = '●',
        current_frame = '◉',
    },
    expand_lines = true,
    force_buffers = true,
    controls = {
        enabled = true,
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
        element = '',
    },
    floating = {
        border = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        max_height = 0.5,
        max_width = 0.5,
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    render = {
        indent = 1,
        unicode = { scale = 1 },
    },
    layouts = {
        default = {
            {
                id = 1,
                size = 0.25,
                breakpoints = { 'breakpoints' },
                watches = { 'watches' },
            },
            {
                id = 2,
                size = 0.25,
                stack = { 'stacks' },
            },
            {
                id = 3,
                size = 0.5,
                scopes = { 'scopes' },
            },
        },
    },
    element_mappings = {},
    mappings = {
        expand = { '<CR>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
    },
    sidebar = {
        elements = {
            'scopes',
            'breakpoints',
            'stacks',
            'watches',
        },
        width = 40,
        position = 'left', -- Can be "left" or "right"
    },
}

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close

local keymap = vim.keymap.set
local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

keymap('n', '<F5>', dap.continue, opts 'Debug: Continue')
keymap('n', '<leader>dn', dap.step_over, opts 'Debug: Step Over')
keymap('n', '<leader>di', dap.step_into, opts 'Debug: Step Into')
keymap('n', '<leader>do', dap.step_out, opts 'Debug: Step Out')
keymap('n', '<leader>db', dap.toggle_breakpoint, opts 'Debug: Toggle Breakpoint')
keymap('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, opts 'Debug: Set Breakpoint')
keymap('n', '<leader>dr', dap.repl.open, opts 'Debug: Open REPL')
keymap('n', '<leader>lp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input 'log point message: ')
end, opts 'Debug: Log Point')
