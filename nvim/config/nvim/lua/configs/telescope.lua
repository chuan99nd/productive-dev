local M = {}

---------------------------------------------------
--- Telescope config
-- Function to jump to the selected quickfix entry
function jump_to_quickfix_entry()
    local qflist = vim.fn.getqflist()      -- Get the quickfix list
    if #qflist > 0 then
        vim.cmd('cc ' .. vim.fn.line('.')) -- Jump to the line using :cc
    end
end

-- Function to search selected text in Telescope
function SearchSelectedText()
    -- Get the visually selected text
    local selected_text = vim.fn.escape(vim.fn.getreg('v'), '\\') -- Get visual selection
    require('telescope.builtin').grep_string({ search = selected_text })
end

-- Helper function to get the current visual selection
function get_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    if #lines == 0 then return '' end

    -- Handle single-line selection
    if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
        -- Handle multi-line selection
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end

    return table.concat(lines, '\n')
end

-- Function to search selected text in Telescope
function SearchSelectedText()
    local selected_text = get_visual_selection() -- Get selected text
    -- selected_text = vim.fn.escape(selected_text, '()[]{}^$.*+?|\\')
    require('telescope.builtin').grep_string({ search = selected_text })
end

function search_diagnostics()
    require('telescope.builtin').diagnostics({
        bufnr = 0,                       -- Current buffer
        layout_strategy = "horizontal",
        layout_config = { height = 0.5 } -- Customize layout if needed
    })
end

function M.setup()
    -- Set the mapping for the quickfix window
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
            vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':lua jump_to_quickfix_entry()<CR>',
                { noremap = true, silent = true })
        end,
    })
    -- Map '#' in visual mode to Telescope search
    vim.api.nvim_set_keymap('v', '#', ':lua SearchSelectedText()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>rf', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
end

return M
