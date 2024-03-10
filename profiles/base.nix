{ config, pkgs, systemSettings, userSettings, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = systemSettings.timeZone;

  # Select internationalisation properties
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Baseline packages for all machines
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Set vim as the default editor
  environment.variables.EDITOR = "vim";
  programs.vim.defaultEditor = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.primaryUser} = {
    isNormalUser = true;
    description = userSettings.primaryUser;
    extraGroups = userSettings.primaryGroups;
  };


  # Automatic Upgrades
  # https://nixos.org/manual/nixos/stable/#sec-upgrading-automatic
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Flakes
  # https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
