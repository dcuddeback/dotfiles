source ~/.bashrc

# bash copmletions for asdf
if [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
  source "$HOME/.asdf/completions/asdf.bash"
fi

# bash completion from Homebrew
if [ -d "/usr/local/etc/bash_completion.d" ]; then
  if [ -f "/usr/local/etc/bash_completion.d/git-completion.bash"      ]; then source "/usr/local/etc/bash_completion.d/git-completion.bash";      fi
  if [ -f "/usr/local/etc/bash_completion.d/git-flow-completion.bash" ]; then source "/usr/local/etc/bash_completion.d/git-flow-completion.bash"; fi
  if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh"            ]; then source "/usr/local/etc/bash_completion.d/git-prompt.sh";            fi
  if [ -f "/usr/local/etc/bash_completion.d/cargo"                    ]; then source "/usr/local/etc/bash_completion.d/cargo";                    fi
fi

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

# JAVA_HOME for OSX
if [ -d /System/Library/Frameworks/JavaVM.framework/Home/ ]; then
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
fi

# JAVA_HOME for Linux
if [ -d /usr/lib/jvm/java-6-openjdk/ ]; then
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/
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
