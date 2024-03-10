{ lib, config, pkgs, ... }:

{
  home.packages = [ pkgs.starship ];
  programs.starship.enable = true;

  programs.starship.enableBashIntegration = true;
  programs.starship.settings = {
    format = lib.concatStrings [
      "[┌───> ](bold pink)$git_branch $git_status"
      "\n"
      "[│](bold pink)$directory"
      "\n"
      "[\\\$](purple) "
    ];
    add_newline = true;
    scan_timeout = 10;

    palette = "dracula";
    palettes.dracula = {
      blue = "#8be9fd";
      purple = "#bd93f9";
      pink = "#ff79c6";
    };

    package.disabled = true;
  };
}
