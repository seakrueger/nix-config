{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.primaryUser;
  home.homeDirectory = "/home/${userSettings.primaryUser}";

  imports =
    [
      ./../../modules/system/bash.nix
      ./../../modules/system/git.nix
      ./../../modules/system/vim.nix
      ./../../modules/system/starship.nix

      ./../../modules/programs/kitty.nix
      ./../../modules/programs/firefox.nix
    ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
