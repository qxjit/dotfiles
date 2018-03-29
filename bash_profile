# vi: ft=sh

set -o vi
export PATH=$HOME/bin:$PATH
export EDITOR=nvim

function rgb () {
  local r=$1
  local g=$2
  local b=$3
  local text=$4

  printf "\[\x1b[38;2;${r};${g};${b}m\]${text}\[\x1b[0m\]"
}

if [[ "$COLORTERM" == "truecolor" ]]; then
  export PS1=$(
  rgb 144 144 144 "\h ";
  rgb 176 204 85 "\u ";
  rgb 191 173 235 "\W ";
  rgb 144 144 144 "\\$ ";
  )
fi
