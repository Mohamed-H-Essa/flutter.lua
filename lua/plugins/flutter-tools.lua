return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("flutter-tools").setup({})

      -- Flutter keybindings starting with 'F'
      local opts = { noremap = true, silent = true }

      -- Flutter run and control
      vim.keymap.set("n", "Fr", ":FlutterRun<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Run" }))
      vim.keymap.set("n", "Fq", ":FlutterQuit<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Quit" }))
      vim.keymap.set("n", "FR", ":FlutterRestart<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Restart" }))
      vim.keymap.set("n", "Fh", ":FlutterReload<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Hot Reload" }))

      -- Flutter devices and emulators
      vim.keymap.set("n", "Fd", ":FlutterDevices<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Devices" }))
      vim.keymap.set("n", "Fe", ":FlutterEmulators<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Emulators" }))

      -- Flutter outline and widgets
      vim.keymap.set(
        "n",
        "Fo",
        ":FlutterOutlineToggle<CR>",
        vim.tbl_extend("force", opts, { desc = "Flutter Outline Toggle" })
      )
      vim.keymap.set(
        "n",
        "Fw",
        ":FlutterOutlineOpen<CR>",
        vim.tbl_extend("force", opts, { desc = "Flutter Outline Open" })
      )

      -- Flutter commands
      vim.keymap.set("n", "Fc", ":FlutterLogClear<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Log Clear" }))
      vim.keymap.set("n", "Fl", ":FlutterLogToggle<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Log Toggle" }))
      vim.keymap.set("n", "Fp", ":FlutterPubGet<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Pub Get" }))
      vim.keymap.set(
        "n",
        "FP",
        ":FlutterPubUpgrade<CR>",
        vim.tbl_extend("force", opts, { desc = "Flutter Pub Upgrade" })
      )

      -- Flutter copy and visual selection
      vim.keymap.set(
        "n",
        "Fy",
        ":FlutterCopyProfilerUrl<CR>",
        vim.tbl_extend("force", opts, { desc = "Flutter Copy Profiler URL" })
      )
      vim.keymap.set(
        "v",
        "Fe",
        ":FlutterVisualDebug<CR>",
        vim.tbl_extend("force", opts, { desc = "Flutter Visual Debug" })
      )

      -- Flutter LSP shortcuts
      vim.keymap.set("n", "Fs", ":FlutterSuper<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Go to Super" }))
      vim.keymap.set("n", "Fi", ":FlutterReanalyze<CR>", vim.tbl_extend("force", opts, { desc = "Flutter Reanalyze" }))
    end,
  },
}
