source ~/.bashrc

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

#export PS1='\e[1;32m\h\e[0m:\e[1;34m\w\e[1;33m$(__git_ps1) \e[0m$ '
export PS1='\e[1;32m\h\e[0m:\e[1;34m\w \e[0m$ '

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim
export GEMEDITOR=mvim

export PAGER=less

alias grep='grep --color=auto'

alias irc='screen -d -RR -S irc irssi'
