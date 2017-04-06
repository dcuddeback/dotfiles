# system default ~/.bashrc
if [ -f "$HOME/.bashrc_default" ]; then
  source "$HOME/.bashrc_default"
fi

function __remove_path {
  PATH=$(echo $PATH | tr : '\n' | grep -v -e "^$1\$" | xargs echo | tr ' ' :)
}

function __prepend_path {
  __remove_path "$1"
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}

function __append_path {
  __remove_path "$1"
  if [ -d "$1" ]; then
    PATH="$PATH:$1"
  fi
}

# local installations
__prepend_path "$HOME/local/bin"

# rbenv
__prepend_path "$HOME/.rbenv/bin"

# Rust/Cargo
__prepend_path "$HOME/.cargo/bin"

# cross-compilers
if [ -d $HOME/x-tools ]; then
  for dir in $(find $HOME/x-tools/ -mindepth 2 -maxdepth 2 -type d -name bin); do
    __append_path "$dir"
  done
fi

# custom scripts
__prepend_path "$HOME/bin"

# help Cargo find SSL certs on NetBSD
if [ -f "/etc/ssl/certs/ca-certificates.crt" ]; then
  export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
fi

export PATH
export BASHRC=true
