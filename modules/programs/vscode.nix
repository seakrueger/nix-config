{ config, pkgs, ... }:

{
  environment.systemPackages = [ 
    (pkgs.vscode-with-extensions.override { 
      vscode = pkgs.vscodium;
      vscodeExtensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        emroussel.atomize-atom-one-dark-theme
        rust-lang.rust-analyzer
        ms-python.python
        jnoortheen.nix-ide
      ];
    })
  ];
}
