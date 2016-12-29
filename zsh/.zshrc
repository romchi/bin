ZSH_THEME="romchi"
CASE_SENSITIVE="False"
HYPHEN_INSENSITIVE="True"
DISABLE_AUTO_UPDATE="True"
DISABLE_LS_COLORS="False"
DISABLE_AUTO_TITLE="True"
DISABLE_UPDATE_PROMPT="True"
ENABLE_CORRECTION="False"
COMPLETION_WAITING_DOTS="False"
DISABLE_UNTRACKED_FILES_DIRTY="True"
HIST_STAMPS="dd/mm/yyyy"
HISTFILE=~/.zhistory

export ZSH=/home/rb/.zsh
export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export EDITOR='vim'

if [[ $(hostname) == "lenovo" ]]; then
  plugins=(git ssh-agent git-prompt)
  zstyle :omz:plugins:ssh-agent agent-forwarding on
else
  plugins=(git git-prompt)

  if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/etoken" ] ; then
    ln -fs "$SSH_AUTH_SOCK" "$HOME/.ssh/etoken"
    export SSH_AUTH_SOCK="$HOME/.ssh/etoken"
  fi
fi

source $ZSH/oh-my-zsh.sh
