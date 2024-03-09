{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.git ];
  programs.git.enable = true;
  programs.git.config = {
    init = {
      defaultBranch = "main";
    };
  };
}
