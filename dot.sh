#! /bin/sh
#
# dot.sh
# Copyright (C) 2016 Roman Bulakh <bulah.roman@gmail.com>
#
# Distributed under terms of the MIT license.
#

#
# RUN
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/romchi/bin/master/dot.sh)"
#

set -e

umask g-w,o-w

if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi
  
if [ ! -n "$ZSH" ]; then
  ZSH=~/.zsh
fi

run_check() {
  printf "${GREEN}Checking installed GIT.${NORMAL}"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
}

run_prepare() {
  # remove dirs to backup if they exist
  printf "${GREEN}Prepare BIN catalog${NORMAL}"
  if [ -d ~/bin ]; then
    printf "${YELLOW}BIN catalog exist. Delete it${NORMAL}\n"
    rm -rf ~/bin
  fi

  printf "${GREEN}Preparing .ZSHRC ${NORMAL}\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}delete it${NORMAL}\n"
    rm -rf ~/.zshrc
  fi

  printf "${GREEN}Preparing .ZSH ${NORMAL}\n"
  if [ -d ~/.zsh ] || [ -h ~/.zsh ]; then
    printf "${YELLOW}Found ~/.zsh.${NORMAL} ${GREEN}delete it${NORMAL}\n"
    rm -rf ~/.zsh
  fi

  printf "${GREEN}Prepare VIM${NORMAL}"
  if [ -d ~/.vim ]; then
    printf "${YELLOW}.vim catalog exist. Delete it${NORMAL}\n"
    rm -rf ~/.vim
  fi

  printf "${GREEN}Prepare VIM${NORMAL}"
  if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
    printf "${YELLOW}.vimrc exist. Delete it${NORMAL}\n"
    rm -rf ~/.vimrc
  fi
}

install() {
  printf "${GREEN}Install bin${NORMAL}\n"
  env git clone https://github.com/romchi/bin.git ~/bin || {
    printf "Error: git clone of bin repo failed\n"
    exit 1
  }
  
  chmod u=rwx,g=,o= -R ~/bin/.

  printf "${GREEN}Clone oh-my-zsh ${NORMAL}\n"
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH || {
    printf "Error: git clone of oh-my-zsh repo failed\n"
    exit 1
  }

  printf "${GREEN}Clone RB config to TMP...${NORMAL}\n"
  env git clone https://github.com/romchi/zsh.git /tmp/zsh_tmp || {
    printf "Error: git clone of RB repo failed\n"
    exit 1
  }

  printf "${GREEN}Clone RB config to ZSH...${NORMAL}\n"
  cp -Ra /tmp/zsh_tmp/. $ZSH/custom && rm -rf /tmp/zsh_tmp || {
    printf "Error: copy RB config from TMP to ZSH\n"
    exit 1
  }

  printf "${GREEN}Clone VIM configs ${NORMAL}\n"
  env git clone https://github.com/romchi/vim.git ~/.vim || {
    printf "${YELLOW}Cannot clone .vim repo.${NORMAL}\n"
    exit 1
  }

  printf "${GREEN}Copy new .vimrc to ~/.vimrc ${NORMAL}\n"
  ln -s ~/.vim/.vimrc ~/.vimrc

  printf "${GREEN}Clone VUNDLE ${NORMAL}\n"
  env git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim ||{
    printf "${YELLOW}Cannot clone Vundle repo.${NORMAL}\n"
    exit 1
  }

  printf "${GREEN}Install Vim plugins...${NORMAL}\n"
  vim +PluginInstall +qall

  printf "${GREEN}Using the Oh My Zsh template file and adding it to ~/.zshrc${NORMAL}\n"
  ln -s $ZSH/custom/.zshrc ~/.zshrc
  sed "/^export ZSH=/ c\\
  export ZSH=$ZSH
  " ~/.zshrc > ~/.zshrc-omztemp
  mv -f ~/.zshrc-omztemp ~/.zshrc

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
      # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not havechsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

  printf "${NORMAL}"
  env zsh
}

run_check
run_prepare
install
