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

return dapui
