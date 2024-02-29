local status_ok, swenv = pcall(require, "swenv")
if not status_ok then
  return
end

swenv.setup({
  -- Should return a list of tables with a `name` and a `path` entry each.
  -- Gets the argument `venvs_path` set below.
  -- By default just lists the entries in `venvs_path`.
  -- adds the base path, which is not in envs/ but in the root path.
  get_venvs = function(venvs_path)
    local venvs = require('swenv.api').get_venvs(venvs_path)
    -- add base env in conda
    local path = os.getenv("CONDA_EXE")
    if path then
      path = vim.fn.fnamemodify(path, ":p:h:h")
      table.insert(venvs, 1, {
        name = "base",
        path = path,
        source = "conda"
      })
    end
    return venvs
  end,
  -- Something to do after setting an environment, for example call vim.cmd.LspRestart
  post_set_venv = function (venv)
    vim.cmd.LspRestart()
  end
})

vim.cmd [[ command! CondaChooseEnv execute 'lua require("swenv.api").pick_venv()' ]]
