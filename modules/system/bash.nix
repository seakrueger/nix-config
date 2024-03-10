{ config, pkgs, profile, ... }:

{
  programs.bash.enableCompletion = true;
  programs.bash.enableLsColors = true;

  programs.bash.shellAliases = {
    ll = "ls -la";

    nixos-edit = "${config.environment.variables.EDITOR} ${config.users.users.general.home}/.nix/profiles/${profile}";
    nixos-update = "sudo nixos-rebuild switch --flake ${config.users.users.general.home}/.nix#${profile}";
    nixos-test = "sudo nixos-rebuild test --flake ${config.users.users.general.home}/.nix#${profile} --option eval-cache false";
  };

  programs.bash.promptInit = ''
    if command -v starship > /dev/null; then
      eval "$(starship init bash)"
      export STARSHIP_CONFIG=${config.users.users.general.home}/.config/starship.toml
    fi
  '';
}
