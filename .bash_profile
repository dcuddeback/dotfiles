source ~/.bashrc

# bash completion from MacPorts
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

# bash completion for git installed by MacPorts
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

# bash completion from Homebrew
if [ -d /usr/local/etc/bash_completion.d ]; then
  source /usr/local/etc/bash_completion.d/*
fi

RED='\[\033[1;31m\]'
GREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[1;34m\]'
DEFAULT='\[\033[0m\]'

function __conditional_git_ps1 {
  (command -v __git_ps1 > /dev/null) && __git_ps1
}

export PS1="${GREEN}\h${DEFAULT}:${BLUE}\W${YELLOW}\$(__conditional_git_ps1)${DEFAULT} \$ "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EDITOR=vim
export GEMEDITOR=mvim
export PAGER=less


if [ $(uname) != "Darwin" ]; then
  alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'
alias irc='screen -d -RR -S irc weechat-curses && clear'
alias can-haz='sudo apt-get install'
alias can-haz?='apt-cache search'

if [ "$(uname)" == "Linux" ]
then
  alias open='gnome-open'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

# It's like grep for oneliners. Thanks to morsch from HN.
cmdfu() {
  wget -qO - "http://www.commandlinefu.com/commands/matching/$@/$(echo -n "$@" | openssl base64)/plaintext"
}

# JAVA_HOME for OSX
if [ -d /System/Library/Frameworks/JavaVM.framework/Home/ ]; then
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
fi

# JAVA_HOME for Linux
if [ -d /usr/lib/jvm/java-6-openjdk/ ]; then
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/
fi

# Node.js version manager
if [ -f ~/nvm/nvm.sh ]; then
  . ~/nvm/nvm.sh
fi

# Ruby env
if command -v rbenv > /dev/null 2>&1 ; then
  eval "$(rbenv init -)"
fi

# load settings specific to the local machine
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

# Use Bundler's --binstubs
export PATH=./bin:$PATH
