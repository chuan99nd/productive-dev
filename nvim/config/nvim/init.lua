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

require('telescope').setup{}
require('configs.telescope').setup()
require('configs.bufferhelper').setup()

