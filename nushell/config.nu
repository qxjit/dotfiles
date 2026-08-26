# Nushell equivalent of ../config.fish, kept in the same order as that file so
# the two can be read side by side while nu is on trial as the main shell.
#
# Needs a nushell with a native helix editing mode: 0.115 has one, 0.110 does
# not (there, `edit_mode` accepted only "emacs" and "vi").

# `set fish_greeting` with no value.
$env.config.show_banner = false


# ---------------------------------------------------------------- prompt ------

# fish's prompt_pwd: $HOME reads as ~, and every component but the last is cut
# down to its first character, keeping a leading dot so .config reads as .c.
def abbreviate-component [part: string] {
  if ($part | is-empty) {
    $part
  } else if ($part | str starts-with ".") {
    $part | str substring 0..1
  } else {
    $part | str substring 0..0
  }
}

def prompt-pwd [] {
  let home = $env.HOME
  let pwd = $env.PWD
  let rel = if $pwd == $home {
    "~"
  } else if ($pwd | str starts-with $"($home)/") {
    $"~/($pwd | path relative-to $home)"
  } else {
    $pwd
  }
  let parts = ($rel | split row "/")

  if ($parts | length) <= 1 {
    $rel
  } else {
    $parts | drop 1 | each { |p| abbreviate-component $p } | append ($parts | last) | str join "/"
  }
}

# fish shells out to `hostname` and `whoami` on every prompt. Neither answer
# changes inside a session, so they are read once here and closed over below.
let host = (sys host | get hostname)
let user = (whoami | str trim)

# The colours are the truecolor halves of the two-argument `set_color` calls in
# config.fish; the brblack/green/magenta second arguments there are fallbacks
# for terminals without truecolor, which nushell has no equivalent for.
$env.PROMPT_COMMAND = {||
  let code = ($env.LAST_EXIT_CODE? | default 0)
  let boom = if $code != 0 { $" 💥 ($code) 💥" } else { "" }

  [
    (ansi { fg: "#909090" }) $host " "
    (ansi { fg: "#b0cc55" }) $user " "
    (ansi { fg: "#bfadeb" }) (prompt-pwd)
    (ansi { fg: "#ff3334", attr: b }) $boom
  ] | str join
}

# fish draws no right prompt; nushell shows the time there unless told otherwise.
$env.PROMPT_COMMAND_RIGHT = ""

# Modal editing replaces $env.PROMPT_INDICATOR with one indicator per mode,
# which is why the "> " that ended the fish prompt appears twice. Helix mode
# reads the VI_-named variables rather than any HELIX_-named ones, and select
# mode shares the normal-mode indicator -- a selection is visible from its own
# highlight.
#
# Insert mode keeps the grey of the original; normal mode takes the pwd's mauve
# so the mode is legible without a statusline. Unlike the fish prompt these
# reset the colour at the end, so what gets typed shows in the terminal's own
# foreground instead of inheriting the trailing grey.
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi { fg: '#909090' })> (ansi reset)"
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi { fg: '#bfadeb', attr: b })> (ansi reset)"


# ------------------------------------------------------------------ path ------

# fish_user_paths is prepended to PATH, and the ghcup line then puts
# ~/.cabal/bin ahead of all of it and ~/.ghcup/bin behind everything, so the
# order below is the order fish ends up with.
$env.PATH = (
  $env.PATH
  | prepend [
      $"($env.HOME)/.local/bin"
      $"($env.HOME)/.cargo/bin"
      $"($env.HOME)/.python/bin"
      $"($env.HOME)/dotfiles/bin"
      $"($env.HOME)/bin"
    ]
  | prepend $"($env.HOME)/.cabal/bin"
  | append $"($env.HOME)/.ghcup/bin"
  | uniq
)


# ------------------------------------------------------- environment ----------

# config.fish spells this ~ out as /home/qxjit; $env.HOME is the same thing on
# this machine and survives being read on another. Empty entries are dropped,
# which the fish version does not do -- there, an unset XDG_DATA_DIRS left a
# trailing colon, and a trailing colon means "the current directory".
$env.XDG_DATA_DIRS = ([
  $"($env.HOME)/.local/share/flatpak/exports/share"
  "/var/lib/flatpak/exports/share"
  ($env.XDG_DATA_DIRS? | default "")
] | where { |d| $d | is-not-empty } | str join ":")

$env.DOCKER_HOST = $"unix:///run/user/((id -u) | str trim)/docker.sock"

# The fish line uses a plain `set`, so this is shell-local there and not passed
# to child processes. Nushell has no unexported variables, so this one is
# exported -- the only behavioural difference in the translation.
if ($env.GHCUP_INSTALL_BASE_PREFIX? | is-empty) {
  $env.GHCUP_INSTALL_BASE_PREFIX = $env.HOME
}


# --------------------------------------------------------- editing mode -------

$env.config.edit_mode = "helix"

# Block in normal and select mode, bar in insert, the way helix draws it.
$env.config.cursor_shape.helix_normal = "block"
$env.config.cursor_shape.helix_select = "block"
$env.config.cursor_shape.helix_insert = "line"
