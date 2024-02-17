local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

local dapui_python_status_ok, dapui = pcall(require, "dapui")
if not dapui_python_status_ok then
  return
end


dapui.setup({
  layouts = { {
    elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25
      }, {
        id = "stacks",
        size = 0.25
      }, {
        id = "watches",
        size = 0.25
      } },
    position = "left",
    size = 0.2
  }, {   -- want console on left side of repl
    elements = { {
        id = "console",
        size = 0.5
      }, {
        id = "repl",
        size = 0.5
      } },
    position = "bottom",
    size = 0.4
  } },
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

vim.cmd [[ command! DapUIClose execute 'lua require("dapui").close()' ]]
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end
