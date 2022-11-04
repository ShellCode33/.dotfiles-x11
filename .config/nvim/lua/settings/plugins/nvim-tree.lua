require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  sort_by = "case_sensitive",
  remove_keymaps = true, -- remove default mappings
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "r", action = "rename" },
        { key = "q", action = "close" },
        { key = "E", action = "expand_all" },
        { key = "C", action = "collaspe_all" },
        { key = "<CR>", action = "edit" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
      custom = { ".git" }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
})
