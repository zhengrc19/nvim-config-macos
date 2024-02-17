local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

keymap({"n", 'v'}, "<leader>b", dap.toggle_breakpoint, opts)
keymap({"n", 'v'}, "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
keymap({'n', 'v'}, '<Leader>lp', function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
keymap('n', '<F5>', dap.continue, opts)
keymap('n', '<leader>dc', dap.continue, opts)
keymap('n', '<F10>', dap.step_over, opts)
keymap('n', '<leader>dl', dap.step_over, opts)
keymap('n', '<F11>', dap.step_into, opts)
keymap('n', '<leader>dj', dap.step_into, opts)
keymap('n', '<F12>', dap.step_out, opts)
keymap('n', '<leader>dk', dap.step_out, opts)
keymap('n', '<Leader>dr', dap.restart, opts)
keymap('n', '<C-c>', dap.close, opts)
keymap('n', '<Leader>dd', dap.run_last, opts)
keymap({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, opts)
keymap({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, opts)
keymap('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, opts)
keymap('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, opts)
