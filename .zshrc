# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Menonaktifkan pengecekan status git yang berat
SET_RETURN_STATUS=true
OH_MY_ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [ ! -d $OH_MY_ZSH_CACHE_DIR ]; then
  mkdir -p $OH_MY_ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#######################
###ALIAS MANUAL AREA###
#######################

alias wifilist='nmcli device wifi list'
alias shutdown='sudo poweroff'

batinfo() {
  cap=$(< /sys/class/power_supply/BAT0/capacity)
  state=$(< /sys/class/power_supply/BAT0/status)

  [[ "$state" == "Charging" ]] && icon="⚡" || icon="🔋"

  printf "%s %s%% (%s)\n" "$icon" "$cap" "$state"
}

unalias wificonnect 2>/dev/null || true
wificonnect() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Penggunaan: wificonnect <SSID> <password>"
    echo "Contoh: wificonnect \"Nama\" \"password\""
    return 1
  fi
  nmcli device wifi connect "$1" password "$2"
}

launch_pure_gui() {
  local app_cmd=$1
  shift
  clear && tput civis
  local term_id=$(hyprctl activewindow -j | jq -r '.address')
  hyprctl dispatch movetoworkspacesilent special:tty_background,address:$term_id
  $app_cmd "$@"
  # Script Stops here until the application is closed and then continues to move the terminal back to the original workspace and focus it
  hyprctl dispatch movetoworkspace e+0,address:$term_id
  hyprctl dispatch focuswindow address:$term_id
  tput cnorm
  clear
}

alias brave='launch_pure_gui brave-browser'
alias code='launch_pure_gui  code'
alias postman='launch_pure_gui  postman'

add_to_path() {
  if [[ -z "$1" ]]; then
    echo "Usage: add_to_path <name_of_application>"
    echo "Example: add_to_path thunar"
    return 1
  fi

  local app_name=$1
  local zsh_file="$HOME/.zshrc"

  if grep -q "alias ${app_name}=" "$zsh_file"; then
    echo "Application '${app_name}' is already registered in aliases."
    return 0
  fi

  sed -i "/# --- AUTOMATIC FULLSCREEN BY REPLACING TERMINAL ---/a alias ${app_name}='exec ${app_name}'" "$zsh_file"
  
  echo "Successfully registered '${app_name}'. Please run 'source ~/.zshrc'"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh