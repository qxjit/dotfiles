set fish_greeting

function fish_prompt
  printf "%s%s %s%s %s%s%s> " \
    (set_color 909090 brblack) (hostname) \
    (set_color b0cc55 green) (whoami) \
    (set_color bfadeb magenta) (prompt_pwd) \
    (set_color 909090 brblack)
end

set fish_user_paths \
  $HOME/.local/bin \
  $HOME/.cargo/bin \
  $HOME/dotfiles/bin \
  $HOME/bin \
  /usr/local/go/bin \
  $HOME/go/bin

set -x DOCKER_HOST unix:///run/user/1000/docker.sock

if [ "$NVIM_LISTEN_ADDRESS" != "" ] && type -q nvr;
  set -x EDITOR "nvr -cc split --remote-wait"
  alias nvim=nvr
else
  set -x EDITOR nvim
end
