PATH=/opt/local/bin:/opt/local/sbin:$PATH   # macports
PATH=$PATH:/opt/local/lib/postgresql90/bin  # postgresql90
PATH=$HOME/bin:$PATH                        # custom scripts

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH
export BASHRC=true
