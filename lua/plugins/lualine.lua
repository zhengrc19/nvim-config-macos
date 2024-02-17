local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local swenv_exist, swenv_api = pcall(require, "swenv.api")

if not swenv_exist then
  LINE_X = {'encoding', 'fileformat', 'filetype'}
else
  LINE_X = {
    'encoding',
    'fileformat',
    {'filetype', cond = function () return vim.bo.filetype ~= "python" end},
    {"swenv", icon = "󰌠", cond = function() return vim.bo.filetype == "python" end,}
  }
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
  sections = { lualine_x = LINE_X },
  extensions = {
    "nvim-tree",
    "toggleterm",
  },
})
