{ config, pkgs, profile, ... }:

{
  programs.bash.shellAliases = {
    ll = "ls -la";

    nixos-edit = "${config.environment.variables.EDITOR} ${config.users.users.general.home}/.nix/profiles/${profile}";
  };

  programs.bash.promptInit = ''
    if command -v starship > /dev/null; then
      eval "$(starship init bash)"
      export STARSHIP_CONFIG=~/.config/starship.toml
    fi
  '';
}
