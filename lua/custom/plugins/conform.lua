return { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    opts = {
        notify_on_error = true,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true, rust = true }
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
            clang = { 'clang-format' },
            cpp = { 'clang-format' },
            c = { 'clang-format' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescriptreact = { 'prettier' },
            go = { 'gofumpt' },
            json = { 'prettier' },
            html = { 'prettier' },
            markdown = { 'prettier' },
            python = { 'ruff', 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            sql = { 'sqlfmt' },
            dockerfile = { 'dockerfilelint' },
            toml = { 'taplo' },
            yaml = { 'kube-linter', 'yamlfmt', 'prettier' },
            rust = { 'rustfmt' },
        },
        formatters = {
            clang_format = {
                -- prepend_args = { '-style="{IndentWidth: 4}"' },
                prepend_args = { '-style=file', '--fallback-style=LLVM' },
            },
            shfmt = {
                prepend_args = { '-i', '4' },
            },
            rustfmt = {
                -- Use the rustfmt.toml in your project root
                -- If you want to use a global one, you can specify the path here
                -- command = 'rustfmt',
                -- args = { '--config-path', '/path/to/your/rustfmt.toml' },
            },
        },
    },
}
