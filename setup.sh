#!/usr/bin/env bash

# backup system .bashrc
if [ -f "$HOME/.bashrc" -a \! -L "$HOME/.bashrc" ]; then
  echo "move: $HOME/.bashrc -> $HOME/.bashrc_default"
  mv "$HOME/.bashrc" "$HOME/.bashrc_default"
fi

# link dotfiles (skip .git directory and setup.sh; handle .cargo/config and dconf separately)
for file in $(ls -A "$HOME/dotfiles/"); do
  if [ "$file" = ".git" -o "$file" = "setup.sh" -o "$file" = ".cargo" -o "$file" = "dconf" ]; then
    continue
  fi

  if [ \! -e "$HOME/$file" ]; then
    echo "link: $HOME/$file -> $HOME/dotfiles/$file"
    ln -s "$HOME/dotfiles/$file" $HOME
  fi
done

# link .cargo/config
if [ \! -L "$HOME/.cargo/config" ]; then
  if [ \! -d "$HOME/.cargo" ]; then
    mkdir "$HOME/.cargo"
  fi

  echo "link: $HOME/.cargo/config -> $HOME/dotfiles/.cargo/config"
  ln -s "$HOME/.cargo/config" "$HOME/.cargo/"
fi

# load dconf settings
if [ "$(which dconf)" ]; then
  for file in $(find "$HOME/dotfiles/dconf" -type f); do
    path="${file#"$HOME/dotfiles/dconf"}/"

    echo "dconf: $path"
    dconf load "$path" < "$file"
  done
fi
