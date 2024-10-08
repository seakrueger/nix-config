{ config, pkgs, userSettings, ... }:

{
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  programs.vim.settings = {
    expandtab = true;
    tabstop = 4;
    shiftwidth = 4;
  };
  programs.vim.extraConfig = ''
    filetype plugin on
    syntax on
  '';
}
