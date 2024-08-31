# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, userSettings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./../base.nix

      ./../../modules/nixpkgs/app/communication.nix
      ./../../modules/nixpkgs/game/steam.nix
      ./../../modules/nixpkgs/shell/lunarvim.nix
    ];

  services.fwupd = {
    enable = true;
    # https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/7040-amd#getting-the-fingerprint-sensor-to-work
    # package = (import (builtins.fetchTarball {
    #   url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
    #   sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
    # }) {
    #  inherit (pkgs) system;
    # }).fwupd;
  };

  security.pam.services.sudo.fprintAuth = false;
  security.pam.services.login.fprintAuth = false;

  # EC issue on amd frameworks
  hardware.framework.amd-7040.preventWakeOnAC = true;

  networking.hostName = "framework"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
    elisa
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.primaryUser}.packages = with pkgs; [
    thunderbird
    libreoffice

    darktable
    davinci-resolve
    gimp
    kicad

    vlc
    ffmpeg
    exiftool
  ];

  fonts.fontDir.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
