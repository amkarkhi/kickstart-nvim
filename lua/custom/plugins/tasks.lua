return {
    'Shatur/neovim-tasks',
    opts = {
        setup = function()
            require('tasks').setup {}
        end,
    },
}
