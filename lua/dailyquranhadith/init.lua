local main = require("dailyquranhadith.main")
local verses = require("dailyquranhadith.verses")

local config = {
    verses = verses,
    mode = "daily" -- can be "daily" or "random"
}

vim.api.nvim_create_user_command("DailyQuranHadith", function()
    main.show_verse(config)
end, {}) 