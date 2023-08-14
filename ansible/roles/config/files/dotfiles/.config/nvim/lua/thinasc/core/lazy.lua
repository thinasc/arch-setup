local status, lazy = pcall(require, "lazy")
if not status then
  print("Lazy is not installed")
  return
end

lazy.setup({
  spec = {
    { import = "thinasc.plugins" },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
