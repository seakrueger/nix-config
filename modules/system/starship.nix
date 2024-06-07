{ lib, config, pkgs, ... }:

{
  home.packages = [ pkgs.starship ];
  programs.starship.enable = true;

  programs.starship.enableBashIntegration = true;
  programs.starship.settings = {
    format = lib.concatStrings [
      "[┌───> ](bold pink)$git_branch $git_status"
      "\n"
      "[│](bold pink)$directory$nix_shell"
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

    nix_shell = {
      symbol = "❄️";
      format = "[$symbol](blue)";
    };

    package.disabled = true;
  };
}
