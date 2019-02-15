# vi: ft=sh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

if [[ "$NVIM_LISTEN_ADDRESS" != "" ]] &&
   [[ $(type -p nvr) ]]; then
  export EDITOR="nvr -cc split --remote-wait"
  alias nvim=nvr
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

if [ -e /Users/qxjit/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/qxjit/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/qxjit/Applications/google-cloud-sdk/path.bash.inc' ]; then . '/Users/qxjit/Applications/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/qxjit/Applications/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/qxjit/Applications/google-cloud-sdk/completion.bash.inc'; fi
