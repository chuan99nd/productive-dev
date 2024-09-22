local M = {}


function close_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

function close_buffers_to_the_right()
  local current_buf = vim.api.nvim_get_current_buf()   -- Get current buffer
  local current_bufnr = vim.fn.bufnr('%')              -- Get current buffer number
  local buffers = vim.fn.getbufinfo({ buflisted = 1 }) -- Get a list of all listed buffers

  for _, buf in ipairs(buffers) do
    if buf.bufnr > current_bufnr then                       -- Check if buffer is to the right (higher number)
      vim.api.nvim_buf_delete(buf.bufnr, { force = false }) -- Close buffer
    end
  end
end

function M.setup()
  -- Close all except current tab
  vim.api.nvim_set_keymap('n', '<A-w>', ':lua close_other_buffers()<CR>', { noremap = true, silent = true })
  -- Close tab the right
  vim.api.nvim_set_keymap('n', '<A-r>', ':lua close_buffers_to_the_right()<CR>', { noremap = true, silent = true })
end

return M
