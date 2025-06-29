local IS_DEV = false

local prompts = {
    -- Code related prompts
    Explain = 'Please explain how the following code works.',
    Review = 'Please review the following code and provide suggestions for improvement.',
    Tests = 'Please explain how the selected code works, then generate unit tests for it.',
    Refactor = 'Please refactor the following code to improve its clarity and readability.',
    FixCode = 'Please fix the following code to make it work as intended.',
    FixError = 'Please explain the error in the following text and provide a solution.',
    BetterNamings = 'Please provide better names for the following variables and functions.',
    Documentation = 'Please provide documentation for the following code.',
    SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
    SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
    -- Text related prompts
    Summarize = 'Please summarize the following text.',
    Spelling = 'Please correct any grammar and spelling errors in the following text.',
    Wording = 'Please improve the grammar and wording of the following text.',
    Concise = 'Please rewrite the following text to make it more concise.',
}

-- read env and see if http_proxy is enable disable the proxy if not set the proxy to  MYPROXY var
--
local MYPROXY = 'http://127.0.0.1:8118'

local http_proxy = os.getenv 'http_proxy'
if http_proxy and http_proxy ~= '' then
    MYPROXY = http_proxy
end

return {
    -- { import = 'plugins.extras.copilot-vim' }, -- Or use { import = "lazyvim.plugins.extras.coding.copilot" },
    {
        dir = IS_DEV and '~/Projects/research/CopilotChat.nvim' or nil,
        'CopilotC-Nvim/CopilotChat.nvim',
        branch = 'main',
        dependencies = {
            { 'nvim-telescope/telescope.nvim' }, -- Use telescope for help actions
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            -- proxy = 'socks5://127.0.0.1:8086',
            proxy = MYPROXY,

            prompts = prompts,
            auto_follow_cursor = false, -- Don't follow the cursor after getting response
            mappings = {
                close = { normal = 'q' }, -- Close chat
                reset = { normal = '<C-l>' }, -- Clear the chat buffer
                complete = {
                    insert = '<Tab>',
                    detail = 'Use @<Tab> or /<Tab> for options',
                }, -- Change to insert mode and press tab to get the completion
                submit_prompt = { normal = '<CR>', insert = '<C-m>' }, -- Submit question to Copilot Chat
                accept_diff = { normal = '<C-y>', insert = '<C-y>' }, -- Accept the diff
                yank_diff = { normal = 'gy' },
                show_diff = { normal = 'gd' },
                show_info = { normal = 'gp' },
                show_context = { normal = 'gs' },
            },
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
                width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
                height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
                -- Options below only apply to floating windows
                relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
                border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                row = nil, -- row position of the window, default is centered
                col = nil, -- column position of the window, default is centered
                title = 'Copilot Chat', -- title of chat window
                footer = nil, -- footer of chat window
                zindex = 1, -- determines if window is on top or below other floating windows
            },
        },
        config = function(_, opts)
            local chat = require 'CopilotChat'
            local select = require 'CopilotChat.select'
            -- Use unnamed register for the selection
            opts.selection = select.unnamed

            -- Override the git prompts message
            opts.prompts.Commit = {
                prompt = 'Write commit message for the change with commitizen convention',
                selection = select.gitdiff,
            }
            opts.prompts.CommitStaged = {
                prompt = 'Write commit message for the change with commitizen convention',
                selection = function()
                    -- selection = function(source)
                    -- return select.gitdiff(source, true)
                    return select.gitdiff()
                end,
            }

            chat.setup(opts)

            vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = '*', range = true })

            -- Inline chat with Copilot
            vim.api.nvim_create_user_command('CopilotChatInline', function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = 'float',
                        relative = 'cursor',
                        width = 1,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = '*', range = true })

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = '*', range = true })
        end,
        event = 'VeryLazy',
        keys = {
            -- Show help actions with telescope
            {
                '<leader>ah',
                function()
                    local copilot_chat = require 'CopilotChat'
                    local actions = require 'CopilotChat.actions'
                    -- require('CopilotChat.integrations.telescope').pick(actions.help_actions())
                    copilot_chat.select_prompt(actions.help_actions)
                end,
                desc = 'CopilotChat - Help actions',
            },
            -- Show prompts actions with telescope
            {
                '<leader>ap',
                function()
                    local copilot_chat = require 'CopilotChat'
                    local actions = require 'CopilotChat.actions'
                    -- require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
                    copilot_chat.select_prompt(actions)
                end,
                desc = 'CopilotChat - Prompt actions',
            },
            {
                '<leader>ap',
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions())<CR>",
                mode = 'x',
                desc = 'CopilotChat - Prompt actions',
            },
            -- Code related commands
            { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
            { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
            { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
            { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
            { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
            -- Chat with Copilot in visual mode
            {
                '<leader>av',
                ':CopilotChat<cr>',
                mode = 'x',
                desc = 'CopilotChat - Open in vertical split',
            },
            {
                '<leader>ax',
                ':CopilotChatInline<cr>',
                mode = 'x',
                desc = 'CopilotChat - Inline chat',
            },
            -- Custom input for CopilotChat
            {
                '<leader>ai',
                function()
                    local input = vim.fn.input 'Ask Copilot: '
                    if input ~= '' then
                        vim.cmd('CopilotChat ' .. input)
                    end
                end,
                desc = 'CopilotChat - Ask input',
            },
            -- Generate commit message based on the git diff
            {
                '<leader>am',
                '<cmd>CopilotChatCommit<cr>',
                desc = 'CopilotChat - Generate commit message for all changes',
            },
            {
                '<leader>aM',
                '<cmd>CopilotChatCommitStaged<cr>',
                desc = 'CopilotChat - Generate commit message for staged changes',
            },
            -- Quick chat with Copilot
            {
                '<leader>aq',
                function()
                    local input = vim.fn.input 'Quick Chat: '
                    if input ~= '' then
                        vim.cmd('CopilotChatBuffer ' .. input)
                    end
                end,
                desc = 'CopilotChat - Quick chat',
            },
            -- Debug
            { '<leader>ad', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - Debug Info' },
            -- Fix the issue with diagnostic
            { '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
            -- Clear buffer and chat history
            { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
            -- Toggle Copilot Chat Vsplit
            { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle Vsplit' },
        },
    },
}
