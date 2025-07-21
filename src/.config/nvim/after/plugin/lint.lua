local lint = require("lint")

-- Set up global linters
lint.linters_by_ft = {
    gitcommit = { "commitlint" },
    python = { "mypy" },
    ["*"] = { "cspell" },
}

local function try_lint_with_globals()
    -- Run linters for filetype
    lint.try_lint()

    local global_linters = lint.linters_by_ft["*"]

    -- Run global linters
    if #global_linters > 0 then
        -- Check if the linter is available, otherwise it will throw an error.
        for _, name in ipairs(global_linters) do
            lint.try_lint(name)
        end
    end
end

-- Register autocmd for linting
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = try_lint_with_globals,
})
