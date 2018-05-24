# vi: ft=sh

set -o vi
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

if [[ "$NVIM_LISTEN_ADDRESS" != "" ]] &&
   [[ $(type -p nvr) ]]; then
  export EDITOR="nvr -cc split --remote-wait"
else
  export EDITOR=nvim
fi

# Make sure ls on OSX knows it can do colors
export CLICOLOR=1

# Make some brighter colors, especially for directories
export LSCOLORS=GxFxCxDxBxegedabagaced

function rgb () {
  local r=$1
  local g=$2
  local b=$3
  local text=$4

  printf "\[\x1b[38;2;${r};${g};${b}m\]${text}\[\x1b[0m\]"
}

# Check for both COLORTERM or TMUX here because TMUX
# nulls out COLORTERM.
if [[ "$COLORTERM" == "truecolor" ]] ||
   [[ "$TMUX" != "" ]]; then
  export PS1=$(
  rgb 144 144 144 "\h ";
  rgb 176 204 85 "\u ";
  rgb 191 173 235 "\W ";
  rgb 144 144 144 "\\$ ";
  )
fi

