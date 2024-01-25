{zellij-bare-bar}: ''
  default_mode "locked"
  default_layout "default"
  default_shell "fish"
  theme "ferra"
  on_force_close "quit"
  pane_frames false
  scrollback_editor "hx"
  copy_on_select true
  mouse_mode true

  themes {
      dracula {
          fg 248 248 242
          bg 68 71 90
          black 68 71 90
          red 255 85 85
          green 80 250 123
          yellow 241 250 140
          blue 98 114 164
          magenta 255 121 198
          cyan 139 233 253
          white 255 255 255
          orange 255 184 108
      }
      gruvbox {
          fg 168 153 132
          bg 69 64 61
          black 60 56 54
          red 204 36 29
          green 152 151 26
          yellow 215 153 33
          blue 69 133 136
          magenta 177 98 134
          cyan 104 157 106
          white 235 219 178
          orange 214 93 14
      }
      nord {
          fg 216 222 233 // #D8DEE9
          bg 46 52 64 // #2E3440
          black 59 66 82 // #3B4252
          red 191 97 106 // #BF616A
          green 163 190 140 // #A3BE8C
          yellow 235 203 139 // #EBCB8B
          blue 129 161 193 // #81A1C1
          magenta 180 142 173 // #B48EAD
          cyan 136 192 208 // #88C0D0
          white 229 233 240 // #E5E9F0
          orange 208 135 112 // #D08770
      }
      ferra {
          fg "#fecdb2"
          bg "#4D424C" // Really this is selection color
          black "#393538"
          red "#e06b75"
          green "#9f9f7c"
          yellow "#fff27a"
          blue "#e88c6f"
          magenta "#ffb9cc"
          cyan "#ffb9cc"
          white "#ffffff"
          orange "#ffa07a"
      }
  }

  plugins {
      tab-bar { path "tab-bar"; }
      status-bar { path "status-bar"; }
      strider { path "strider"; }
      compact-bar { path "compact-bar"; }
      bare-bar { path "${zellij-bare-bar}/bin/bare-bar.wasm"; }
  }

  keybinds clear-defaults=true {
      normal {
          bind "r" { SwitchToMode "resize"; }
          bind "m" { SwitchToMode "move"; }
          bind "s" { SwitchToMode "scroll"; }
          bind "/" { SwitchToMode "entersearch"; SearchInput 0; }
          bind "d" { Detach; }
          bind "|" { NewPane "Right"; SwitchToMode "locked"; }
          bind "-" { NewPane "Down"; SwitchToMode "locked"; }
          bind "n" { NewPane; SwitchToMode "locked"; }
          bind "x" { CloseFocus; SwitchToMode "locked"; }
          bind "c" { NewTab; SwitchToMode "locked"; }
          bind "q" { CloseTab; SwitchToMode "locked"; }
          bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "locked"; }
          bind "," { SwitchToMode "renametab"; TabNameInput 0; }
          bind "h" { MoveFocus "Left"; SwitchToMode "locked"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "locked"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "locked"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "locked"; }
          bind "1" { GoToTab 1; SwitchToMode "locked"; }
          bind "2" { GoToTab 2; SwitchToMode "locked"; }
          bind "3" { GoToTab 3; SwitchToMode "locked"; }
          bind "4" { GoToTab 4; SwitchToMode "locked"; }
          bind "5" { GoToTab 5; SwitchToMode "locked"; }
          bind "6" { GoToTab 6; SwitchToMode "locked"; }
          bind "7" { GoToTab 7; SwitchToMode "locked"; }
          bind "8" { GoToTab 8; SwitchToMode "locked"; }
          bind "9" { GoToTab 9; SwitchToMode "locked"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "locked"; }
      }
      locked {
          bind "Ctrl a" { SwitchToMode "normal"; }
      }
      resize {
          bind "h" "Left" { Resize "Left"; }
          bind "j" "Down" { Resize "Down"; }
          bind "k" "Up" { Resize "Up"; }
          bind "l" "Right" { Resize "Right"; }
          bind "+" "=" { Resize "Increase"; }
          bind "-" { Resize "Decrease"; }
          bind "Esc" { SwitchToMode "locked"; }
      }
      move {
          bind "h" "Left" { MovePane "Left"; }
          bind "j" "Down" { MovePane "Down"; }
          bind "k" "Up" { MovePane "Up"; }
          bind "l" "Right" { MovePane "Right"; }
          bind "Esc" { SwitchToMode "locked"; }
      }
      renametab {
          bind "Enter" { SwitchToMode "locked"; }
          bind "Esc" { UndoRenameTab; SwitchToMode "locked"; }
      }
      scroll {
          bind "j" { ScrollDown; }
          bind "k" { ScrollUp; }
          bind "Ctrl u" { HalfPageScrollUp; }
          bind "Ctrl d" { HalfPageScrollDown; }
          bind "g" { ScrollToTop; }
          bind "e" { ScrollToBottom; }
          bind "i" { EditScrollback; SwitchToMode "locked"; }
          bind "/" { SwitchToMode "entersearch"; SearchInput 0; }
          bind "Esc" { ScrollToBottom; SwitchToMode "locked"; }
      }
      entersearch {
          bind "Enter" { SwitchToMode "search"; }
          bind "Esc" { SwitchToMode "scroll"; }
      }
      search {
          bind "j" { ScrollDown; }
          bind "k" { ScrollUp; }
          bind "Ctrl u" { HalfPageScrollUp; }
          bind "Ctrl d" { HalfPageScrollDown; }
          bind "g" { ScrollToTop; }
          bind "e" { ScrollToBottom; }
          bind "n" { Search "down"; }
          bind "p" { Search "up"; }
          bind "c" { SearchToggleOption "CaseSensitivity"; }
          bind "w" { SearchToggleOption "Wrap"; }
          bind "o" { SearchToggleOption "WholeWord"; }
          // TODO: Copy doesn't work on search "selections", upstream fix
          // bind "y" { Copy; }
          bind "/" { SwitchToMode "entersearch"; SearchInput 0; }
          bind "Enter" { SwitchToMode "scroll"; }
          bind "Esc" { ScrollToBottom; SwitchToMode "locked"; }
      }
  }
''
