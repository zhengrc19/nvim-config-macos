local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
  return
end

local dapui_python_status_ok, dapui = pcall(require, "dapui")
if not dapui_python_status_ok then
  return
end

dapui.setup()
dap_python.setup('~/mambaforge/bin/python')
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
