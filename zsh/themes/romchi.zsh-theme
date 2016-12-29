# vim: set ts=2 textwidth=0

autoload -U add-zsh-hook

local c_free=$(printf "\033[0m")
local c_black=$(printf "\033[38;5;235m")
local c_black_bold=$(printf "\033[38;5;235m")
local c_fiolet=$(printf "\033[38;5;129m")
local c_fiolet_bold=$(printf "\033[38;5;129m")
local c_grey=$(printf "\033[38;5;241m")
local c_grey_bold=$(printf "\033[38;5;241m")
local c_red=$(printf "\033[38;5;160m")
local c_red_bold=$(printf "\033[38;5;160m")
local c_brown=$(printf "\033[38;5;136m")
local c_brown_bold=$(printf "\033[1;38;5;136m")
local c_green=$(printf "\033[38;5;34m")
local c_green_bold=$(printf "\033[38;5;34m")
local c_yellow=$(printf "\033[38;5;11m")
local c_yellow_bold=$(printf "\033[38;5;11m")
local c_blue=$(printf "\033[38;5;21m")
local c_blue_bold=$(printf "\033[38;5;21m")
local c_orange=$(printf "\033[38;5;202m")
local c_orange_bold=$(printf "\033[38;5;202m")
local c_purple=$(printf "\033[38;5;201m")
local c_purple_bold=$(printf "\033[1;38;5;201m")
local c_wblue=$(printf "\033[38;5;39m")
local c_wblue_bold=$(printf "\033[1;38;5;39m")
local c_white=$(printf "\033[38;5;15m")
local c_white_bold=$(printf "\033[1;38;5;15m")
local c_folder=$(printf "\033[1;38;5;45m")

if [ "$TERM" = "linux" ]; then
    c_black=$(printf "\033[30m")
    c_black_bold=$(printf "\033[30;1m")
    c_red=$(printf "\033[31m")
    c_red_bold=$(printf "\033[31;1m")
    c_green=$(printf "\033[32m")
    c_green_bold=$(printf "\033[32;1m")
    c_yellow=$(printf "\033[33m")
    c_yellow_bold=$(printf "\033[33;1m")
    c_blue=$(printf "\033[34m")
    c_blue_bold=$(printf "\033[34;1m")
    c_purple=$(printf "\033[35m")
    c_purple_bold=$(printf "\033[35;1m")
    c_wblue=$(printf "\033[36m")
    c_wblue_bold=$(printf "\033[36;1m")
    c_white=$(printf "\033[37m")
    c_white_bold=$(printf "\033[37;1m")
fi

if [ $EUID -eq 0 ]; then P_UCOLOR="%{$fg_bold[red]%}"; else P_UCOLOR="%{$fg_bold[green]%}"; fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[grey]%}git:%{$fg[green]%}|%{$c8%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[green]%}|%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="➤ %{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

local hist_number="%!"
local ret_status="⇵%?"

function battery {
  pwr=`/home/rb/bin/batery_prompt.sh`
  if [[ $pwr -le 10 ]]; then
    print $c_red⚡$pwr$c_free;
  elif [[ $pwr -le 40 ]]; then
    print $c_orange⚡$pwr$c_free;
  elif [[ $pwr -le 70 ]]; then
    print $c_yellow⚡$pwr$c_free;
  elif [[ $pwr -le 100 ]]; then
    print $c_green⚡$pwr$c_free;
  fi
}

_echoti() {
    emulate -L zsh
    (( ${+terminfo[$1]} )) && echoti $1
}

term_reset() {
  emulate -L zsh
  [[ -n $TTY ]] && (( $+terminfo )) && {
    _echoti rmacs  # Отключает графический режим
    _echoti sgr0   # Убирает цвет
    _echoti cnorm  # Показывает курсор
    _echoti smkx   # Включает «keyboard transmit mode»
    echo -n $'\e[?47l' # Отключает alternate screen
    # See https://github.com/fish-shell/fish-shell/issues/2139 for smkx
  }
}


chprompt() {
  power=$(battery)
  RPROMPT=$(git_prompt_short_sha)
  PROMPT="%{$c_wblue%}╭── %{$c_free%}%{$P_UCOLOR%}%n %{$c_free%}%{$c_grey%}at %{$c_free%}%{$P_UCOLOR%}%m %{$c_free%}%{$c_grey%}in %{$c_free%}%{$c_fiolet%}%l%{$c_free%} %{$c_red%}[ $(battery) %{$c_grey%}$ret_status %{$c_red_bold%}]%{$c_free%}%{$c_grey%}-> %{$c_free%}%{$c_folder%}%/
%{$c_wblue%}╰──%{$P_UCOLOR%}> %{$c_free%}"
}

zmodload zsh/terminfo && precmd_functions+=( term_reset )
ttyctl -f
add-zsh-hook precmd chprompt
