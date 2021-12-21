{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "marco.chan";
  home.homeDirectory = "/Users/marco.chan";
}

