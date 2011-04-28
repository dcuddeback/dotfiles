source ~/.bashrc

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

GREEN='\[\033[1;32m\]'
BLUE='\[\033[1;34m\]'
DEFAULT='\[\033[0m\]'

export PS1="${GREEN}\h${DEFAULT}:${BLUE}\W${DEFAULT} \$ "

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim
export GEMEDITOR=mvim

export PAGER=less

alias grep='grep --color=auto'

alias irc='screen -d -RR -S irc irssi'
