{ config, pkgs, profile, ... }:

{
  programs.bash.enable = true;

  programs.bash.enableCompletion = true;
  programs.bash.enableVteIntegration = true;

  programs.bash.shellAliases = {
    ll = "ls -la";

    nixos-edit = "${config.home.sessionVariables.EDITOR} ${config.home.homeDirectory}/.nix/profiles/${profile}";
    nixos-update = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.nix#${profile}";
    nixos-test = "sudo nixos-rebuild test --flake ${config.home.homeDirectory}/.nix#${profile} --option eval-cache false";
  };

  programs.bash.initExtra = ''
    if command -v starship > /dev/null; then
      eval "$(starship init bash)"
      export STARSHIP_CONFIG=${config.home.homeDirectory}/.config/starship.toml
    fi
  '';
}
