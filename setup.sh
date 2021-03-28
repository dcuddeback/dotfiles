#!/usr/bin/env bash

# backup system .bashrc
if [ -f "$HOME/.bashrc" -a \! -L "$HOME/.bashrc" ]; then
  echo "move: $HOME/.bashrc -> $HOME/.bashrc_default"
  mv "$HOME/.bashrc" "$HOME/.bashrc_default"
fi

HISTORIES=".bash_history .lesshst .wget-hsts"
HISTORIES="$HISTORIES .psql_history .mysql_history .rediscli_history"
HISTORIES="$HISTORIES .python_history .julia_history .octave_hist .gnuplot_history"

# disable history files
for file in $HISTORIES; do
  echo "link: $HOME/$file -> /dev/null"
  rm -f "$HOME/$file"
  ln -s /dev/null "$HOME/$file"
done

# link dotfiles (skip .git directory and setup.sh; handle .cargo/*, .config/*, and dconf/* separately)
for file in $(ls -A "$HOME/dotfiles/"); do
  if [ "$file" = ".git" -o "$file" = "setup.sh" -o "$file" = ".cargo" -o "$file" = ".config" -o "$file" = "dconf" ]; then
    continue
  fi

  if [ \! -e "$HOME/$file" ]; then
    echo "link: $HOME/$file -> $HOME/dotfiles/$file"
    ln -s "$HOME/dotfiles/$file" $HOME
  fi
done

# link contents of .cargo/ and .config/ directories
for dir in .cargo .config; do
  for file in $(ls -A "$HOME/dotfiles/$dir/"); do
    if [ \! -L "$HOME/$dir/$file" ]; then
      if [ \! -d "$HOME/$dir" ]; then
        mkdir "$HOME/$dir"
      fi

      echo "link: $HOME/$dir/$file -> $HOME/dotfiles/$dir/$file"
      ln -s "$HOME/dotfiles/$dir/$file" "$HOME/$dir/"
    fi
  done
done

# load dconf settings
if [ "$(which dconf)" ]; then
  for file in $(find "$HOME/dotfiles/dconf" -type f); do
    path="${file#"$HOME/dotfiles/dconf"}/"

    echo "dconf: $path"
    dconf load "$path" < "$file"
  done
fi
