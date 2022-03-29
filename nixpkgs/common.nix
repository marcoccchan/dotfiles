{ config, pkgs, nixpkgs, ... }:

let
  HOME = config.home.homeDirectory;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages to install
  home.packages = [
    # pkgs is the set of all packages in the default home.nix implementation
    pkgs.tmux
    pkgs.zsh
    pkgs.clojure
    pkgs.leiningen
    pkgs.clj-kondo
    pkgs.openjdk11
    pkgs.git
    pkgs.fzf
    pkgs.git-extras
    pkgs.jq
  ];

  nixpkgs.overlays = [(final: prev:
	  let
	    isM1 = prev.stdenv.hostPlatform.system == "aarch64-darwin";
	    pkgs_x86_64 = import <nixpkgs> { localSystem = "x86_64-darwin"; };
	    pkgs =
	      if isM1
	      then pkgs_x86_64
	      else prev;
	  in
	  {
	    emacsMacport = pkgs.emacsMacport;
	    babashka = pkgs.babashka;
	    clj-kondo = pkgs.clj-kondo;
        tmux = pkgs.tmux;
	    kafkacat = pkgs.kafkacat;
	    openjdk11 = pkgs.openjdk11;
	    # overrides the java version used in e.g. leiningen
	    jdk = pkgs.openjdk11;
	  }
  )];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      if [[ -s ${HOME}/.secrets ]]; then
        source "${HOME}/.secrets"
      fi
    '';
    initExtra = ''
      HIST_FIND_NO_DUPS="true";

      # Theme (https://github.com/sindresorus/pure)
      fpath+=/opt/homebrew/share/zsh/site-functions
      autoload -U promptinit; promptinit
      zstyle :prompt:pure:path color yellow
      prompt pure
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "docker-compose" "thefuck" ];
    };
  };

  programs.git = {
    enable = true;
    userName = "Marco Chan";
    extraConfig = {
      github = {
        user = "marcoccchan";
      };
    };
    ignores = [
      ".DS_Store"
      ".idea"
      "*.iml"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
