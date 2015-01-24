#!/usr/bin/env bash

# backup system .bashrc
if [ -f "$HOME/.bashrc" -a \! -L "$HOME/.bashrc" ]; then
  mv -v "$HOME/.bashrc" "$HOME/.bashrc_default"
fi

# link dotfiles (skip .git directory and setup.sh)
for file in $(ls -A "$HOME/dotfiles/"); do
  if [ "$file" = ".git" -o "$file" = "setup.sh" ]; then
    continue
  fi

  if [ "$file" != ".git" -a \! -e "$HOME/$file" ]; then
    ln -sv "$HOME/dotfiles/$file" $HOME
  fi
done
