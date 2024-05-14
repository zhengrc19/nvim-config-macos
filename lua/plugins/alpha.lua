local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local session_manager_exists, sess_man = pcall(require, "session_manager.utils")

local startify = require('alpha.themes.startify')

startify.section.header.val = {
  -- [[                                                                                           ]],
  -- [[  ██████╗  █████╗ ██╗   ██╗███████╗    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ]],
  -- [[  ██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ]],
  -- [[  ██████╔╝███████║ ╚████╔╝ ███████╗    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ]],
  -- [[  ██╔══██╗██╔══██║  ╚██╔╝  ╚════██║    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]],
  -- [[  ██║  ██║██║  ██║   ██║   ███████║    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ]],
  -- [[  ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ]],

  -- [[   _____             _       _   _                 _             ]],
  -- [[  |  __ \           ( )     | \ | |               (_)            ]],
  -- [[  | |__) |__ _ _   _|/ ___  |  \| | ___  _____   ___ _ __ ___    ]],
  -- [[  |  _  // _` | | | | / __| | . ` |/ _ \/ _ \ \ / / | '_ ` _ \   ]],
  -- [[  | | \ \ (_| | |_| | \__ \ | |\  |  __/ (_) \ V /| | | | | | |  ]],
  -- [[  |_|  \_\__,_|\__, | |___/ |_| \_|\___|\___/ \_/ |_|_| |_| |_|  ]],
  -- [[                __/ |                                            ]],
  -- [[               |___/                                             ]],

  [[     ____             _          _   __                _           ]],
  [[    / __ \____ ___  _( )_____   / | / /__  ____ _   __(_)___ ___   ]],
  [[   / /_/ / __ `/ / / /// ___/  /  |/ / _ \/ __ \ | / / / __ `__ \  ]],
  [[  / _, _/ /_/ / /_/ / (__  )  / /|  /  __/ /_/ / |/ / / / / / / /  ]],
  [[ /_/ |_|\__,_/\__, / /____/  /_/ |_/\___/\____/|___/_/_/ /_/ /_/   ]],
  [[             /____/                                                ]],

  -- [[    ___           _        _  __             _       ]],
  -- [[   / _ \___ ___ _( )___   / |/ /__ ___ _  __(_)_ _   ]],
  -- [[  / , _/ _ `/ // //(_-<  /    / -_) _ \ |/ / /  ' \  ]],
  -- [[ /_/|_|\_,_/\_, / /___/ /_/|_/\__/\___/___/_/_/_/_/  ]],
  -- [[           /___/                                     ]],

}

if session_manager_exists then
  local sessions = sess_man.get_sessions({silent = true})
  local tbl = {}
  local start = 20
  for i,v in ipairs(sessions) do
    table.insert(tbl, startify.button(
      tostring(i + start - 1),
      v.dir.filename,
      [[<cmd>lua require"session_manager.utils".load_session(]]
        .. v.filename .. [[, true)<CR>]]
    ))
  end
  local sess = {
    type = "group",
    val = {
      { type = "padding", val = 1 },
      { type = "text", val = "Sessions",  opts = { hl = "SpecialComment" } },
      { type = "padding", val = 1 },
      {
        type = "group",
        val = tbl,
      }
    },
  }
  if #sessions > 0 then
    table.insert(startify.config.layout, 5, sess)
  end
end

alpha.setup(startify.config)

-- require'alpha'.setup(require'alpha.themes.startify'.config)


-- local alpha = require'alpha'
-- local startify = require'alpha.themes.startify'
-- startify.section.header.val = {
--     [[                                   __                ]],
--     [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
--     [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--     [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--     [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--     [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }
-- startify.section.top_buttons.val = {
--     startify.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
-- }
-- -- disable MRU
-- startify.section.mru.val = { { type = "padding", val = 0 } }
-- -- disable MRU cwd
-- startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
-- -- disable nvim_web_devicons
-- startify.nvim_web_devicons.enabled = true
-- -- startify.nvim_web_devicons.highlight = true
-- -- startify.nvim_web_devicons.highlight = 'Keyword'
-- --
-- startify.section.bottom_buttons.val = {
--     startify.button( "q", "󰅚  Quit NVIM" , ":qa<CR>"),
-- }
-- startify.section.footer.val = {
--     { type = "text", val = "footer" },
-- }
-- -- ignore filetypes in MRU
--
-- startify.mru_opts.ignore = function(path, ext)
--     return
--             (string.find(path, "COMMIT_EDITMSG"))
--         or  (vim.tbl_contains(default_mru_ignore, ext))
-- end
-- alpha.setup(startify.config)
