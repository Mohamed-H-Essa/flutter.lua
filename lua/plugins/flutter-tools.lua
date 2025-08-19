return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim", -- For better notifications
    },
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
        notification_style = "native", -- Use native vim.notify (snacks.nvim handles this in LazyVim)
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = true,
        },
      },
      flutter_path = "/Users/mtech/development/flutter/bin/flutter", -- Explicit path to prevent duplication
      flutter_lookup_cmd = nil, -- Don't use lookup since we have explicit path
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = false, -- Set to true if you use Flutter Version Management
      widget_guides = {
        enabled = false,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = false,
      },
      dev_log = {
        enabled = true,
        filter = function(log_line)
          -- Allow all log lines to pass through, but could add filtering logic here
          -- For example, to filter out verbose logs:
          -- if log_line:match("%[VERBOSE%]") then return false end
          return true
        end,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "30split", -- command to use to open the log buffer
        focus_on_open = true, -- focus on the newly opened log window
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
    config = function(_, opts)
      require("flutter-tools").setup(opts)
      
      -- Enhance dev_log buffer with ANSI color support
      local function setup_flutter_log_colors()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("__FLUTTER_DEV_LOG__") then
          -- Enable ANSI color interpretation for Flutter logs
          vim.bo.filetype = "log"
          vim.bo.buftype = "nofile"
          vim.bo.swapfile = false
          vim.wo.wrap = false
          vim.wo.number = false
          vim.wo.relativenumber = false
          
          -- Set up highlight groups for common Flutter log levels
          vim.api.nvim_set_hl(0, "FlutterLogError", { fg = "#f87171", bold = true })
          vim.api.nvim_set_hl(0, "FlutterLogWarning", { fg = "#fbbf24", bold = true })
          vim.api.nvim_set_hl(0, "FlutterLogInfo", { fg = "#60a5fa", bold = true })
          vim.api.nvim_set_hl(0, "FlutterLogDebug", { fg = "#a3a3a3" })
          vim.api.nvim_set_hl(0, "FlutterLogVerbose", { fg = "#6b7280" })
          vim.api.nvim_set_hl(0, "FlutterLogSuccess", { fg = "#34d399", bold = true })
          vim.api.nvim_set_hl(0, "FlutterLogTime", { fg = "#9ca3af", italic = true })
          vim.api.nvim_set_hl(0, "FlutterLogDevice", { fg = "#8b5cf6", bold = true })
          
          -- Apply syntax highlighting for log levels and patterns
          vim.fn.matchadd("FlutterLogError", "\\c\\[error\\]\\|\\cerror:\\|E/flutter")
          vim.fn.matchadd("FlutterLogWarning", "\\c\\[warning\\]\\|\\cwarning:\\|W/flutter")
          vim.fn.matchadd("FlutterLogInfo", "\\c\\[info\\]\\|\\cinfo:\\|I/flutter\\|flutter:")
          vim.fn.matchadd("FlutterLogDebug", "\\c\\[debug\\]\\|\\cdebug:\\|D/flutter")
          vim.fn.matchadd("FlutterLogVerbose", "\\c\\[verbose\\]\\|\\cverbose:\\|V/flutter")
          vim.fn.matchadd("FlutterLogSuccess", "\\c\\[success\\]\\|\\csuccess:\\|✓.*\\|Application finished")
          vim.fn.matchadd("FlutterLogError", "\\c✗.*\\|\\cfailed.*\\|\\cexception\\|\\cassert.*failed")
          vim.fn.matchadd("FlutterLogTime", "\\d\\d:\\d\\d:\\d\\d\\.\\d\\+")
          vim.fn.matchadd("FlutterLogDevice", "\\[.*\\]\\s*\\(android\\|ios\\|web\\|macos\\|windows\\|linux\\)")
          
          -- Additional Flutter-specific patterns
          vim.fn.matchadd("FlutterLogInfo", "\\cFlutter run key commands\\.")
          vim.fn.matchadd("FlutterLogInfo", "\\cSyncing files to device")
          vim.fn.matchadd("FlutterLogInfo", "\\cConnecting to VM Service")
          vim.fn.matchadd("FlutterLogSuccess", "\\cApplication started")
          vim.fn.matchadd("FlutterLogSuccess", "\\cReloaded.*in.*ms")
          vim.fn.matchadd("FlutterLogSuccess", "\\cRestarted application")
          -- add entry to color anyline that has [log] in it by yellow (debug, warning)
          vim.fn.matchadd("FlutterLogDebug", "\\c\\[log\\]\\|\\cdebug:\\|D/flutter") -- does this line color anything that has [log] in it by yellow?
          vim.fn.matchadd("FlutterLogWarning", "\\c\\[log\\]\\|\\cwarning:\\|W/flutter")
        end
      end
      
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
        pattern = "*",
        callback = setup_flutter_log_colors,
      })
    end,
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
      { "<leader>Fk", function()
          -- Toggle colorful log display
          local log_win = vim.fn.bufwinnr("__FLUTTER_DEV_LOG__")
          if log_win ~= -1 then
            vim.cmd(log_win .. "wincmd w")
            -- Re-apply syntax highlighting
            vim.cmd("syntax clear")
            vim.fn.matchadd("FlutterLogError", "\\c\\[error\\]\\|\\cerror:")
            vim.fn.matchadd("FlutterLogWarning", "\\c\\[warning\\]\\|\\cwarning:")
            vim.fn.matchadd("FlutterLogInfo", "\\c\\[info\\]\\|\\cinfo:")
            vim.fn.matchadd("FlutterLogDebug", "\\c\\[debug\\]\\|\\cdebug:")
            vim.fn.matchadd("FlutterLogVerbose", "\\c\\[verbose\\]\\|\\cverbose:")
            vim.fn.matchadd("FlutterLogSuccess", "\\c\\[success\\]\\|\\csuccess:\\|✓")
            vim.fn.matchadd("FlutterLogSuccess", "\\c✓.*")
            vim.fn.matchadd("FlutterLogError", "\\c✗.*\\|\\cfailed.*\\|\\cerror.*")
            vim.notify("Flutter log colors refreshed!", vim.log.levels.INFO)
          else
            vim.notify("Flutter log window not open", vim.log.levels.WARN)
          end
        end, desc = "Refresh Flutter Log Colors" },
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
    },
  },
}
