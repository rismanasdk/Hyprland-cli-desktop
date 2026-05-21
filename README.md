# Kitty Pure CLI Hyprland Dotfiles

Minimal, terminal-first Hyprland configuration focused on a pure CLI desktop using `kitty` terminals.

**Quick summary**

- **Modular configs:** See [hyprland.conf](hyprland.conf), [keybindings.conf](keybindings.conf), [autostart_cli.conf](autostart_cli.conf).
- **Persistent workspaces:** 1–10 are configured to persist and open a fullscreen `kitty` on startup.
- **Minimal look:** gaps, borders, rounding, and animations are disabled for a snappy experience.

**Requirements (Arch Linux examples)**

- Install `jq`: `sudo pacman -S jq`
- Optional screenshots: `sudo pacman -S grim slurp`

Repository files

- [hyprland.conf](hyprland.conf) — core settings, sources `~/.config/hypr/autostart_cli.conf` and `~/.config/hypr/keybindings.conf`.
- [keybindings.conf](keybindings.conf) — hotkeys and workspace navigation.
- [autostart_cli.conf](autostart_cli.conf) — spawns `kitty` fullscreen on workspaces 1–10.
- [workspace_binds.conf](workspace_binds.conf) — helper binds for moving windows between workspaces.

Usage notes

- To apply changes to your Hyprland configuration after editing any Hypr files run:

  `hyprctl reload`

- If you edit your Zsh configuration (`~/.zshrc`) reload it with:

  `source ~/.zshrc`

Keybindings (high level)

- `SUPER + RETURN` — launch `kitty`
- `SUPER + [1-9]` / `SUPER + 0` — switch to workspaces 1–10
- `SUPER + SHIFT + [0-9]` — move focused window to workspace

Notes

- This repo was tested on Arch Linux; behavior on other distros may vary.
- See `LICENSE` for license details.
