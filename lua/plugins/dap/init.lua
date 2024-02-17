local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
  return
end

local dap_vt_status_ok, dap_vt = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_status_ok then
  return
end

dap_vt.setup()

dap_python.setup('~/mambaforge/bin/python')

local dapui = require("plugins.dap.dapui")

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end

-- auto read launch json in root folder
if vim.loop.fs_stat("./.vscode/launch.json") then
  require('dap.ext.vscode').load_launchjs()
end

local dap_repl_hl_ok, repl_hl = pcall(require, "nvim-dap-repl-highlights")
if not dap_repl_hl_ok then
  return
end

repl_hl.setup()

local repl_treesitter_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/dap_repl.so"
if not vim.loop.fs_stat(repl_treesitter_path) then
  vim.cmd [[ TSInstall dap_repl ]]
end
