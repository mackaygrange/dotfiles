# Dotfiles

Personal configuration files for Linux (i3/Hyprland) and Windows (PowerShell) environments, themed with the [Rosé Pine Moon](https://rosepinetheme.com/) colorscheme.

## What's Included

| Directory       | Description                            |
|-----------------|----------------------------------------|
| `bash/`         | `.bashrc`, `.bash_profile`, `.inputrc`, work environment extras |
| `dunst/`        | Notification daemon configuration      |
| `fonts/`        | CaskaydiaCove Nerd Font                |
| `git/`          | Global `.gitconfig`                    |
| `hypr/`         | Hyprland + Hyprpaper (Wayland WM)      |
| `i3/`           | i3 window manager + lock script (X11)  |
| `i3status/`     | i3status bar configuration             |
| `icons/`        | Custom icons                           |
| `kitty/`        | Kitty terminal emulator configuration  |
| `neofetch/`     | System info splash screen              |
| `nvim/`         | Neovim (lazy.nvim plugin manager)      |
| `picom/`        | X11 compositor                         |
| `PowerShell/`   | Windows PowerShell profile             |
| `rofi/`         | Application launcher (X11)             |
| `scripts/`      | Setup, symlink, and package install scripts |
| `theme/`        | Centralized color palette and `apply-theme.sh` script |
| `tmux/`         | tmux terminal multiplexer              |
| `uwsm/`        | Universal Wayland Session Manager      |
| `wallpapers/`   | Desktop wallpapers                     |
| `waybar/`       | Wayland status bar                     |
| `wofi/`         | Application launcher (Wayland)         |

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/mackaygrange/dotfiles ~/repos/dotfiles
   cd ~/repos/dotfiles
   ```

2. Run the setup script to create symlinks:

   ```bash
   bash scripts/setup_symlinks.sh
   ```

3. Optionally install packages (Ubuntu or Arch):

   ```bash
   bash scripts/install_packages.sh -i
   ```

## Color Palette

All configurations use the **Rosé Pine** colorscheme. See [`rosepine-palette.md`](rosepine-palette.md) for the full color reference.

### Switching Themes

A single script applies any Rosé Pine variant across **all** config files at once:

```bash
# Available variants: moon (default), main, dawn
bash theme/apply-theme.sh moon   # dark – muted
bash theme/apply-theme.sh main   # dark – vivid
bash theme/apply-theme.sh dawn   # light
```

The script updates: i3, i3status, kitty, dunst, hyprland, picom, rofi, wofi, waybar, Neovim, and tmux. Palette definitions live in `theme/<variant>.sh`.

## Notes

- The Neovim configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
- tmux uses [TPM](https://github.com/tmux-plugins/tpm) — press `prefix + I` after first launch to install plugins.
- The i3 and Hyprland configurations are independent and can be used on different machines.
