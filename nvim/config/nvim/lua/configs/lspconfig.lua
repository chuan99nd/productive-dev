-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

require 'lspconfig'.lua_ls.setup {}
-- EXAMPLE
local servers = { "html", "cssls", "pyright", "tsserver" }
local nvlsp = require "nvchad.configs.lspconfig"

vim.opt.timeoutlen = 0
-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- Set up gopls
lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

-- Format on save
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        -- 2
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports" } },
                    apply = true
                })
            end,
        })
    end
})

local cmp = require 'cmp'

-- Use arrow to navigate in cmp menu, use tab to complete copilot's code
cmp.setup({
    sources = cmp.config.sources({
        -- { name = 'copilot' },  -- Copilot suggestions
        { name = 'nvim_lsp' }, -- LSP suggestions
        { name = 'buffer' },   -- buffer suggestions
    }),

    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = function(fallback)
            fallback() -- Use this to fallback to regular tab functionality (e.g., indent)
        end,
    }
})
vim.api.nvim_set_keymap('n', '<C-m>', ':Copilot panel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':Copilot setup<CR>', { noremap = true, silent = true })
