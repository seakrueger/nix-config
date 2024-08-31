{ config, pkgs, ... }:

{
  programs.kitty.enable = true;

  programs.kitty.shellIntegration.enableBashIntegration = true;
  programs.kitty.shellIntegration.mode = "no-rc no-cursor";

  programs.kitty.theme = "Solarized Darcula";

  programs.kitty.keybindings = { };
  programs.kitty.settings = {
    enable_audio_bell = false;  
  };
  programs.kitty.extraConfig = ''
    cursor_shape block

    confirm_os_window_close 0
  '';


  programs.bash.shellAliases = {
    icat = "kitten icat";
  };
}
