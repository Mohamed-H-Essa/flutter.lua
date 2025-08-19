return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "FlutterRun",
      "FlutterDevices",
      "FlutterEmulators",
      "FlutterReload",
      "FlutterRestart",
      "FlutterQuit",
      "FlutterOutlineToggle",
      "FlutterOutlineOpen",
      "FlutterLogClear",
      "FlutterLogToggle",
      "FlutterPubGet",
      "FlutterPubUpgrade",
      "FlutterCopyProfilerUrl",
      "FlutterVisualDebug",
      "FlutterSuper",
      "FlutterReanalyze",
    },
    ft = "dart",
    opts = {},
    keys = {
      -- Flutter group
      { "<leader>F", "", desc = "+flutter", mode = { "n", "v" } },
      
      -- Flutter run and control
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Restart" },
      { "<leader>Fh", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },

      -- Flutter devices and emulators
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },

      -- Flutter outline and widgets
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline Toggle" },
      { "<leader>Fw", "<cmd>FlutterOutlineOpen<cr>", desc = "Flutter Outline Open" },

      -- Flutter commands
      { "<leader>Fc", "<cmd>FlutterLogClear<cr>", desc = "Flutter Log Clear" },
      { "<leader>Fl", "<cmd>FlutterLogToggle<cr>", desc = "Flutter Log Toggle" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
      { "<leader>FP", "<cmd>FlutterPubUpgrade<cr>", desc = "Flutter Pub Upgrade" },

      -- Flutter copy and profiler
      { "<leader>Fy", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Flutter Copy Profiler URL" },
      { "<leader>Fv", "<cmd>FlutterVisualDebug<cr>", desc = "Flutter Visual Debug", mode = "v" },

      -- Flutter LSP shortcuts
      { "<leader>Fs", "<cmd>FlutterSuper<cr>", desc = "Flutter Go to Super" },
      { "<leader>Fi", "<cmd>FlutterReanalyze<cr>", desc = "Flutter Reanalyze" },
    },
  },
}
