return { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            -- local disable_filetypes = {}
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                lsp_format = 'fallback',
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
            json = { 'prettierd' },
            html = { 'prettierd' },
            markdown = { 'prettier' },
            python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            sql = { 'sqlfmt' },
            dockerfile = { 'dockerfilelint' },
        },
        formatters = {
            clang_format = {
                -- prepend_args = { '-style="{IndentWidth: 4}"' },
                prepend_args = { '-style=file', '--fallback-style=LLVM' },
            },
            shfmt = {
                prepend_args = { '-i', '4' },
            },
        },
    },
}
