{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    llvmPackages.bintools
    pkg-config
    openssl
    clang
    rustup
    python3
  ]; 
}
