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
    opts = {
      ui = {
        border = "rounded",
        notification_style = "nvim-notify",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          -- Add custom debug configurations if needed
          require("dap").configurations.dart = {
            {
              type = "dart",
              request = "launch",
              name = "Launch Flutter",
              dartSdkPath = paths.dart_sdk,
              flutterSdkPath = paths.flutter_sdk,
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
              -- args = {"--flavor", "development"}
            }
          }
        end,
      },
      flutter_path = "/Users/mtech/development/flutter/bin/flutter", -- Explicit path to prevent duplication
      flutter_lookup_cmd = nil, -- Don't use lookup since we have explicit path
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = false, -- Set to true if you use Flutter Version Management
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        filter = nil,
        focus_on_open = false,
        open_cmd = "30split",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true, -- Enable color support
          background = false, -- background color support
          background_color = nil, -- background color
          foreground = false, -- foreground color support
          virtual_text = true, -- virtual text color support
          virtual_text_str = " ■", -- virtual text string
        },
        on_attach = nil, -- custom on_attach function
        capabilities = nil, -- custom capabilities
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/.pub-cache"),
            vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
            vim.fn.expand("$HOME/.cache/pub"),
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    },
    keys = {
      -- Flutter group
      { "<leader>F", "", desc = "+flutter", mode = { "n", "v" } },
      
      -- Flutter run and control
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Restart" },
      { "<leader>Fh", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },
      
      -- Alternative run commands for troubleshooting
      { "<leader>FRR", function()
          vim.cmd("FlutterQuit")
          vim.defer_fn(function()
            vim.cmd("FlutterRun")
          end, 1000)
        end, desc = "Flutter Force Restart" },

      -- Flutter devices and emulators
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },

      -- Flutter outline and widgets
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline Toggle" },
      { "<leader>Fw", "<cmd>FlutterOutlineOpen<cr>", desc = "Flutter Outline Open" },

      -- Flutter commands
      { "<leader>Fc", "<cmd>FlutterLogClear<cr>", desc = "Flutter Log Clear" },
      { "<leader>Fl", "<cmd>FlutterLogToggle<cr>", desc = "Flutter Log Toggle" },
      { "<leader>FL", function() 
          vim.cmd("FlutterLogToggle") 
          vim.defer_fn(function()
            local log_win = vim.fn.bufwinnr("__FLUTTER_DEV_LOG__")
            if log_win ~= -1 then
              vim.cmd(log_win .. "wincmd w")
              vim.cmd("normal! G") -- Go to bottom
            end
          end, 100)
        end, desc = "Flutter Log Toggle & Focus" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
      { "<leader>FP", "<cmd>FlutterPubUpgrade<cr>", desc = "Flutter Pub Upgrade" },

      -- Flutter copy and profiler
      { "<leader>Fy", "<cmd>FlutterCopyProfilerUrl<cr>", desc = "Flutter Copy Profiler URL" },
      { "<leader>Fv", "<cmd>FlutterVisualDebug<cr>", desc = "Flutter Visual Debug", mode = "v" },

      -- Flutter LSP shortcuts
      { "<leader>Fs", "<cmd>FlutterSuper<cr>", desc = "Flutter Go to Super" },
      { "<leader>Fi", "<cmd>FlutterReanalyze<cr>", desc = "Flutter Reanalyze" },
      
      -- Flutter development tools
      { "<leader>Ft", "<cmd>FlutterDevTools<cr>", desc = "Flutter Dev Tools" },
      { "<leader>Fb", "<cmd>FlutterDetach<cr>", desc = "Flutter Detach" },
      { "<leader>FA", "<cmd>FlutterRename<cr>", desc = "Flutter Rename" },
      
      -- Flutter path verification
      { "<leader>FV", function()
          local flutter_path = "/Users/mtech/development/flutter/bin/flutter"
          vim.notify("Flutter path: " .. flutter_path, vim.log.levels.INFO)
          -- Test if the path exists
          local handle = io.open(flutter_path, "r")
          if handle then
            handle:close()
            vim.notify("✓ Flutter executable found!", vim.log.levels.INFO)
          else
            vim.notify("✗ Flutter executable not found at: " .. flutter_path, vim.log.levels.ERROR)
          end
        end, desc = "Verify Flutter Path" },
      
      -- Flutter debugging (requires DAP)
      { "<leader>FD", function()
          require("dap").toggle_breakpoint()
        end, desc = "Toggle Breakpoint", ft = "dart" },
      { "<leader>FC", function()
          require("dap").continue()
        end, desc = "Debug Continue", ft = "dart" },
      { "<leader>FS", function()
          require("dap").step_over()
        end, desc = "Debug Step Over", ft = "dart" },
      { "<leader>FI", function()
          require("dap").step_into()
        end, desc = "Debug Step Into", ft = "dart" },
      { "<leader>FO", function()
          require("dap").step_out()
        end, desc = "Debug Step Out", ft = "dart" },
    },
  },
}
