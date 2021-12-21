{ config, pkgs, ... }:

let
  HOME = config.home.homeDirectory;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "marco";
  home.homeDirectory = "/Users/marco";

  # Packages to install
  home.packages = [
    # pkgs is the set of all packages in the default home.nix implementation
    pkgs.tmux
    pkgs.zsh
    pkgs.clojure
    pkgs.openjdk11
    pkgs.clj-kondo
  ];

  programs.zsh = {
    enable = true;
    profileExtra = ''
      . ${HOME}/.nix-profile/etc/profile.d/nix.sh
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  # Raw configuration files
  home.file.".tmux.conf".source = ./tmux.conf;

  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
