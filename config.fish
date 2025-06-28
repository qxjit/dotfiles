set fish_greeting

function fish_prompt
  set check_status $status

  if [ $check_status != 0 ]
    set prompt_status " 💥 $check_status 💥"
  else
    set prompt_status ""
  end


  printf "%s%s %s%s %s%s%s$prompt_status%s> " \
    (set_color 909090 brblack) (hostname) \
    (set_color b0cc55 green) (whoami) \
    (set_color bfadeb magenta) (prompt_pwd) \
    (set_color -o ff3334 brred) \
    (set_color 909090 brblack)
end

set fish_user_paths \
  $HOME/.local/bin \
  $HOME/.cargo/bin \
  $HOME/.python/bin \
  $HOME/dotfiles/bin \
  $HOME/bin

set -x XDG_DATA_DIRS "/home/qxjit/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"

set -x DOCKER_HOST unix:///run/user/(id -u)/docker.sock

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/qxjit/.ghcup/bin # ghcup-env
