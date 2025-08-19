return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Configure the picker sources for explorer
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}

    -- Set the explorer layout to have a larger width
    opts.picker.sources.explorer.layout = {
      preset = "sidebar",
      layout = {
        width = 60, -- Increase width from default 40 to 50
        min_width = 50,
      },
    }

    return opts
  end,
}
