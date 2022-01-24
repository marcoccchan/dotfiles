# Setting up Homebrew

## Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Homebrew Bundle
```
brew bundle
```

# Setting up Nix on MacOS
## Install Nix
```
sh <(curl -L https://nixos.org/nix/install)
```

## Install Package Manager
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

nix-shell '<home-manager>' -A install
```

## Symbolic Link to Github repo
```
cd ~/.config/nixpkgs/

# Work laptop
ln -s /Users/marco.chan/src/dotfiles/nixpkgs/fc.nix home.nix

# Personal laptop
ln -s /Users/marco.chan/src/dotfiles/nixpkgs/personal.nix home.nix
```

