vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.wo.relativenumber = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
  { import = "plugins" },
}, lazy_config)

vim.api.nvim_create_autocmd('ColorScheme', {
          pattern = 'solarized',
          -- group = ...,
          callback = function()
            vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
              fg = '#555555',
              ctermfg = 8,
              force = true
            })
          end
        })-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- Send results to quickfix list and close Telescope
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- You can use this mapping in normal mode as well
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      }
    },
    file_ignore_patterns = {"node_modules", ".git"}
  }
}

---------------------------------------------------
--- Telescope config
-- Function to jump to the selected quickfix entry
function jump_to_quickfix_entry()
  local qflist = vim.fn.getqflist()  -- Get the quickfix list
    if #qflist > 0 then
        vim.cmd('cc ' .. vim.fn.line('.'))  -- Jump to the line using :cc
    end
  end

-- Set the mapping for the quickfix window
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':lua jump_to_quickfix_entry()<CR>', { noremap = true, silent = true })
          end,
          }) 
-- Function to search selected text in Telescope
function SearchSelectedText()
  -- Get the visually selected text
  local selected_text = vim.fn.escape(vim.fn.getreg('v'), '\\') -- Get visual selection
  require('telescope.builtin').grep_string({ search = selected_text })
end

-- Map '#' in visual mode to Telescope search
vim.api.nvim_set_keymap('v', '#', ':lua SearchSelectedText()<CR>', { noremap = true, silent = true })
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
  local selected_text = get_visual_selection()  -- Get selected text
  -- selected_text = vim.fn.escape(selected_text, '()[]{}^$.*+?|\\')
  require('telescope.builtin').grep_string({ search = selected_text })
end
