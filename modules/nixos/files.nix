{ user, ... }:

let
  home           = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome   = "${home}/.local/share";
  xdg_stateHome  = "${home}/.local/state"; in
{

  "${xdg_configHome}/bspwm/bspwmrc" = {
    executable = true;
    text = ''
      #! /bin/sh
      #
      # Set the number of workspaces
      bspc monitor -d 1 2 3 4 5 6

      # Launch keybindings daemon
      pgrep -x sxhkd > /dev/null || sxhkd &

      # Window configurations
      bspc config border_width         0
      bspc config window_gap          16
      bspc config split_ratio          0.52
      bspc config borderless_monocle   true
      bspc config gapless_monocle      true

      # Padding outside of the window
      bspc config top_padding            60
      bspc config bottom_padding         60
      bspc config left_padding           60
      bspc config right_padding          60

      # Move floating windows
      bspc config pointer_action1 move

      # Resize floating windows
      bspc config pointer_action2 resize_side
      bspc config pointer_action2 resize_corner

      # Wait for the network to be up
      notify-send 'Waiting for network...'
      while ! systemctl is-active --quiet network-online.target; do sleep 1; done
      notify-send 'Network found.'

      # Wait for the Emacs daemon
      notify-send 'Starting Emacs...'
      /run/current-system/sw/bin/emacsclient -a "" -e '(progn)' &

      # Wait for Emacs daemon to be ready
      while ! /run/current-system/sw/bin/emacsclient -e '(progn)' &>/dev/null; do
      sleep 1
      done
      notify-send 'Emacs daemon started.'
    '';
  };

  "${xdg_configHome}/sxhkd/sxhkdrc" = {
    text = ''
    # Close window
    alt + F4
          bspc node --close

    # Make split ratios equal
    super + equal
          bspc node @/ --equalize

    # Make split ratios balanced
    super + minus
          bspc node @/ --balance

    # Toogle tiling of window
    super + d
          bspc query --nodes -n focused.tiled && state=floating || state=tiled; \
          bspc node --state \~$state

    # Toggle fullscreen of window
    super + f
          bspc node --state \~fullscreen

    # Swap the current node and the biggest window
    super + g
          bspc node -s biggest.window

    # Swap the current node and the smallest window
    super + shift + g
          bspc node -s biggest.window

    # Alternate between the tiled and monocle layout
    super + m
          bspc desktop -l next

    # Move between windows in monocle layout
    super + {_, alt + }m
          bspc node -f {next, prev}.local.!hidden.window

    # Focus the node in the given direction
    super + {_,shift + }{h,j,k,l}
          bspc node -{f,s} {west,south,north,east}

    # Focus left/right occupied desktop
    super + {Left,Right}
          bspc desktop --focus {prev,next}.occupied

    # Focus left/right occupied desktop
    super + {Up,Down}
          bspc desktop --focus {prev,next}.occupied

    # Focus left/right desktop
    ctrl + alt + {Left,Right}
          bspc desktop --focus {prev,next}

    # Focus left/right desktop
    ctrl + alt + {Up, Down}
          bspc desktop --focus {prev,next}

    # Focus the older or newer node in the focus history
    super + {o,i}
          bspc wm -h off; \
          bspc node {older,newer} -f; \
          bspc wm -h on

    # Focus or send to the given desktop
    super + {_,shift + }{1-9,0}
          bspc {desktop -f,node -d} '^{1-9,10}'

    # Preselect the direction
    super + alt + {h,j,k,l}
          bspc node -p {west,south,north,east}

    # Cancel the preselect
    # For context on syntax: https://github.com/baskerville/bspwm/issues/344
    super + alt + {_,shift + }Escape
          bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

    # Preselect the direction
    super + ctrl + {h,j,k,l}
          bspc node -p {west,south,north,east}

    # Cancel the preselect
    # For context on syntax: https://github.com/baskerville/bspwm/issues/344
    super + ctrl + {_,shift + }Escape
          bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

    # Set the node flags
    super + ctrl + {m,x,s,p}
          bspc node -g {marked,locked,sticky,private}

    # Send the newest marked node to the newest preselected node
    super + y
          bspc node newest.marked.local -n newest.!automatic.local

    # Terminal emulator
    super + Return
          bspc rule -a Alacritty -o state=floating rectangle=1024x768x0x0 center=true && /etc/profiles/per-user/${user}/bin/alacritty

    # Terminal emulator
    super + ctrl + Return
          /etc/profiles/per-user/${user}/bin/alacritty

    # Jump to workspaces
    super + t
          bspc desktop --focus ^2
    super + b
          bspc desktop --focus ^1
    super + w
          bspc desktop --focus ^4
    super + Tab
          bspc {node,desktop} -f last

    # Keepass XC
    super + shift + x
          /etc/profiles/per-user/${user}/bin/keepassxc

    # Emacs
    # -c flag is --create-frame
    # -a flag is fallback to plain emacs if daemon fails
    super + alt + Return
         emacsclient -c -a emacs

    super + alt + e
         systemctl --user restart emacs.service && \
         emacsclient -c -a emacs

    # Web browser
    ctrl + alt + Return
         google-chrome-stable

    # File browser at home dir
    super + shift + @space
         pcmanfm

    # Take a screenshot with PrintSc
    Print
         flameshot gui -c -p $HOME/.local/share/img/screenshots

    # Lock the screen
    ctrl + alt + BackSpace
         i3lock

    # Audio controls for + volume
    XF86AudioRaiseVolume
        pactl set-sink-volume @DEFAULT_SINK@ +5%

    # Audio controls for - volume
    XF86AudioLowerVolume
        pactl set-sink-volume @DEFAULT_SINK@ -5%

    # Audio controls for mute
    XF86AudioMute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    '';
  };
}
