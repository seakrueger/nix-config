{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kitty ];
  programs.kitty.enable = true;

  programs.kitty.shellIntegration.enableBashIntegration = true;
  programs.kitty.theme = "Solarized Darcula";
  programs.kitty.keybindings = { };
  programs.kitty.settings = {
    enable_audio_bell = false;  
  };
  programs.kitty.extraConfig = "confirm_os_window_close 0";
}
