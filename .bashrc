if [ -f ~/.bashrc_default ]; then
  source ~/.bashrc_default
fi

PATH=/opt/local/bin:/opt/local/sbin:$PATH   # macports
PATH=$PATH:/opt/local/lib/postgresql90/bin  # postgresql90
PATH=$PATH:/opt/local/lib/mysql5/bin        # mysql

# Android SDK tools
if [ -d $HOME/android-sdk-mac_x86/tools ]; then
  PATH=$PATH:$HOME/android-sdk-mac_x86/tools
fi

PATH=$HOME/bin:$PATH                        # custom scripts

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH
export BASHRC=true
