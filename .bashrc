if [ -f ~/.bashrc_default ]; then
  source ~/.bashrc_default
fi

PATH=/opt/local/bin:/opt/local/sbin:$PATH   # macports
PATH=$PATH:/opt/local/lib/postgresql90/bin  # postgresql90
PATH=$PATH:/opt/local/lib/mysql5/bin        # mysql
PATH=~/.rbenv/bin:$PATH                     # rbenv
PATH=/usr/local/bin:$PATH                   # homebrew
PATH=$HOME/local/bin:$PATH                  # local installations

# Go
if [ -d /usr/local/Cellar/go/1.2/libexec/bin ]
then
  PATH=$PATH:/usr/local/Cellar/go/1.2/libexec/bin
fi

# Android SDK tools
if [ -d $HOME/android-sdk-linux/ ]
then
  PATH=$PATH:$HOME/android-sdk-linux/tools
  PATH=$PATH:$HOME/android-sdk-linux/platform-tools
fi

if [ -d $HOME/android-sdk-mac_x86/ ]
then
  PATH=$PATH:$HOME/android-sdk-mac_x86/tools
  PATH=$PATH:$HOME/android-sdk-mac_x86/platform-tools
fi

# Raspberry Pi cross-compiler
if [ -d $HOME/x-tools/armv6-rpi-linux-gnueabi/bin ]; then
  PATH=$PATH:$HOME/x-tools/armv6-rpi-linux-gnueabi/bin
fi

PATH=$HOME/bin:$PATH                        # custom scripts

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# NVM
[[ -s "$HOME/.nvm/nvm.sh" ]]      && source "$HOME/.nvm/nvm.sh"

export PATH
export BASHRC=true
