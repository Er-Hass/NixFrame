{ config, pkgs, ... }:
{
  programs.zsh.enable = true;     # system shell availability; HM will manage user config

  environment.systemPackages = with pkgs; [
    curl wget htop btop jq tree
    # dev helpers
    gcc gnumake pkg-config
  ];
}
