# Setting up Nix on MacOS
## Install Nix
```
❯ curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume
```

## Install Package Manager
```
❯ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

❯ nix-channel --update

❯ nix-shell '<home-manager>' -A install
```

## Symbolic Link to Github repo
```
# Work laptop
ln -s /Users/marco.chan/src/dotfiles/nixpkgs/fc.nix home.nix

# Personal laptop
ln -s /Users/marco.chan/src/dotfiles/nixpkgs/personal.nix home.nix
```

