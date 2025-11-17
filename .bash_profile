source ~/.bashrc

# bash copmletions for asdf
if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
  source "$HOME/.asdf/completions/asdf.bash"
fi

# bash completion from Homebrew
for path in `find /opt/homebrew/etc/bash_completion.d`; do
  if [ ! -d $path ]; then
    source $path
  fi
done

# bash completion for SSH
if [ $(uname) == "Darwin" ]; then
  if [ -f $HOME/.ssh/config ]; then
    complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh
  fi
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
export PAGER=less

if [ "$(uname)" == "Linux" ]
then
  alias open='gnome-open'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

# Make use of keychain (if installed) to manage ssh-agent and gpg-agent
if command -v keychain > /dev/null 2>&1 ; then
  eval `keychain --eval`
fi

# load settings specific to the local machine
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi

export PATH
