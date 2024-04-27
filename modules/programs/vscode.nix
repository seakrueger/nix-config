{ config, pkgs, ... }:

{
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;

  programs.vscode.userSettings = {
    "security.workspace.trust.enabled" = false;
    "workbench.colorTheme" = "Atomize";
  };

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    vscodevim.vim
    emroussel.atomize-atom-one-dark-theme
    rust-lang.rust-analyzer
    ms-python.python
    jnoortheen.nix-ide
  ];
}
