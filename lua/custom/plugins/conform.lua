return { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
        notify_on_error = false,
        format_on_save = function()
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            -- local disable_filetypes = { c = true, cpp = true }
            return {
                timeout_ms = 500,
            }
        end,
        stop_after_first = true,
        formatters_by_ft = {
            lua = { 'stylua' },
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            clang = { 'clang-format' },
            cpp = { 'clang-format' },
            c = { 'clang-format' },
            javascript = { 'prettierd' },
            typescript = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            typescriptreact = { 'prettierd' },
            go = { 'gofumpt' },
            json = { 'prettier' },
            html = { 'prettier' },
            markdown = { 'prettier' },
            python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        },
    },
}
