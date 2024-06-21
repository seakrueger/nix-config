{ config, pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    git
    gh
  ];

  programs.git.userName = userSettings.name;
  programs.git.userEmail = userSettings.email;
  programs.git.extraConfig = {
    init.defaultBranch = "main";
  };
}
