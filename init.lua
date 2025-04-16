-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Install package manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
  {
    dir = vim.fn.stdpath("config") .. "/lua/dailyquranhadith",
    config = function()
      local dailyquran = require("dailyquranhadith")
      if type(dailyquran) == "table" and dailyquran.setup then
        dailyquran.setup({
          mode = "daily",
          display_type = "both"
        })
      else
        vim.notify("Failed to load dailyquranhadith plugin", vim.log.levels.ERROR)
      end
    end,
  }
})

-- Key mappings
vim.g.mapleader = " " -- Set leader key to space
vim.keymap.set('n', '<leader>q', ':DailyQuranHadith<CR>', { noremap = true, silent = true, desc = "Show Daily Quran/Hadith" })

-- Commands
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("DailyQuranHadith")
    end
  end,
})

