 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#131314', -- Default Background
     base01 = '#1f2020', -- Lighter Background (status bars)
     base02 = '#2a2a2a', -- Selection Background
     base03 = '#8d9194', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#c3c7ca', -- Dark Foreground (status bars)
     base05 = '#e4e2e2', -- Default Foreground
     base06 = '#e4e2e2', -- Light Foreground
     base07 = '#e4e2e2', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#cfc2d2', -- Integers, Constants
     base0A = '#c3c7ca', -- Classes, Search Background
     base0B = '#bcc8d1', -- Strings, Diff Inserted
     base0C = '#cfc2d2', -- Regex, Escape Chars
     base0D = '#bcc8d1', -- Functions, Methods
     base0E = '#c3c7ca', -- Keywords, Storage
     base0F = '#93000a', -- Deprecated, Embedded Tags
   }
 end

 M.load = M.setup

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
