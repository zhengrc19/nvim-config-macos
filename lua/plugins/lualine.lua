local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup({
  options = {
    theme = 'onedark',
    component_separators = {left = "|", right = "|"},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {
      "NvimTree",
      "dap-repl",
      "dapui_console",
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_stacks",
    },
    always_divide_middle = false,
  },
  extensions = {
    "nvim-tree",
    "toggleterm",
  },
})
