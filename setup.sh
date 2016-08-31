#!/usr/bin/env bash

# backup system .bashrc
if [ -f "$HOME/.bashrc" -a \! -L "$HOME/.bashrc" ]; then
  mv -v "$HOME/.bashrc" "$HOME/.bashrc_default"
fi

# link dotfiles (skip .git directory and setup.sh; handle .cargo/config separately)
for file in $(ls -A "$HOME/dotfiles/"); do
  if [ "$file" = ".git" -o "$file" = "setup.sh" -o "$file" = ".cargo" ]; then
    continue
  fi

  if [ \! -e "$HOME/$file" ]; then
    ln -sv "$HOME/dotfiles/$file" $HOME
  fi
done

if [ \! -L "$HOME/.cargo/config" ]; then
  if [ \! -d "$HOME/.cargo" ]; then
    mkdir "$HOME/.cargo"
  fi

  ln -sv "$HOME/.cargo/config" "$HOME/.cargo/"
fi
