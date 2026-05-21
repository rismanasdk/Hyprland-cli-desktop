# Kitty Pure CLI Hyprland Dotfiles

A collection of dotfiles for the **Hyprland** window manager, specifically engineered around a **Pure CLI Desktop Ecosystem** concept. This setup is built to be ultra-minimalist, blazing fast, animation-free, and automatically turns every workspace into a pure TTY-like terminal environment right from boot time.

## Key Features

* **Modular Config:** Clean structure separated by function into `hyprland.conf`, `keybindings.conf`, and `autostart_cli.conf`.
* **10 Persistent Workspaces:** Workspaces 1 through 10 are locked to remain active (*persistent*) and will not collapse when a terminal window is closed.
* **Instant Terminal Autostart:** Upon login, the system utilizes native execution rules to spawn a **Kitty** terminal window in *fullscreen* mode across all 10 workspaces in the background.
* **Super Snappy & Rice-less:** Gaps, borders, and rounding are all set to `0`, with all animations entirely disabled for maximum performance and distraction-free command-line focus.

## Repository Structure

```text
~/.config/hypr/
├── hyprland.conf         # Core settings & environment variables
├── autostart_cli.conf    # Automated per-workspace application spawning
├── keybindings.conf      # Custom hotkeys & workspace navigation
└── .gitignore            # Git ignore rules

## How to use

Hotkey,Action
SUPER + RETURN,Launch a new Kitty terminal instance
SUPER + Q,Kill the active focused window
SUPER + F,Toggle window fullscreen status
SUPER + [1-9],Switch active view to Workspace 1 through 9
SUPER + 0,Switch active view to Workspace 10
SUPER + SHIFT + [0-9],Move the focused window to the targeted workspace
SUPER + SHIFT + E,Terminate the current Hyprland session


## Attention
I haven't tried using this config in any distribution other than Arch Linux

## License 
See [LICENSE](LICENSE) for license details.