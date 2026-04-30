return function()
    local lint = require("lint")

    -- Set up global linters
    lint.linters_by_ft = {
        gitcommit = { "commitlint" },
        python = { "ruff", "mypy" },
        ["*"] = { "cspell" },
    }

    local function lint_all()
        -- Run linters for filetype
        lint.try_lint()

        local global_linters = lint.linters_by_ft["*"] or {}

        -- Run global linters
        for _, name in ipairs(global_linters) do
            lint.try_lint(name)
        end
    end

    -- Register autocmds for linting
    vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave" }, {
        callback = lint_all,
    })

    -- Lint after format
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function(_)
            vim.defer_fn(lint_all, 50)
        end,
    })
end
