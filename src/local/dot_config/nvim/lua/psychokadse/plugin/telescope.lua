return function()
    local project = require("psychokadse.core.project")
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    telescope.setup({
        extensions = {
            undo = {
                side_by_side = true,
                layout_strategy = "vertical",
            },
        },
    })

    telescope.load_extension("undo")
    telescope.load_extension("harpoon")

    vim.keymap.set("n", "<leader>pf", function()
        builtin.find_files({ cwd = vim.uv.cwd(), hidden = true, no_ignore = true, no_ignore_parent = true })
    end, { desc = "Find files" })
    vim.keymap.set("n", "<C-p>", function()
        -- Ensure root is git repo root so paths don't break
        project.ensure_root(project.get_git_root())
        builtin.git_files()
    end, { desc = "Git files" })
    vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({
            cwd = vim.uv.cwd(),
            search = vim.fn.input("Grep > "),
            use_regex = true,
            additional_args = { "--hidden" },
        }) -- Additional args correspond to ripgrep CLI args
    end, { desc = "Grep string" })
    -- undo
    vim.keymap.set("n", "<leader>uv", function()
        telescope.extensions.undo.undo()
    end, { desc = "Find in undo history" })
    -- harpoon
    vim.keymap.set("n", "<leader>hf", function()
        telescope.extensions.harpoon.marks()
    end, { desc = "Find harpoon marks" })
end
