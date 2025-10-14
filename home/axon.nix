{ config, pkgs, ... }:
let
  kittyTheme = ''
    font_size 11.5
    enable_audio_bell no
    background_opacity 0.98
  '';
in
{
  home.username = "axon";
  home.homeDirectory = "/home/axon";
  programs.home-manager.enable = true;

  # Shell + prompt + history + direnv
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 50000;
    initExtra = ''
      bindkey -v
    '';
  };

  programs.starship.enable = true;
  programs.atuin.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Terminal + multiplexer
  programs.kitty = {
    enable = true;
    extraConfig = kittyTheme;
  };
  programs.zellij.enable = true;

  # Browser (Wayland)
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.wayland-dmabuf-vaapi.enabled" = true;
      };
    };
  };

  # Neovim will be added declaratively later (nixvim/nvf); keep stock for now.
  programs.neovim.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
  ];

  # Keep this minimal now; we’ll grow it steadily.
  home.stateVersion = "25.05"; # set to your target NixOS version
}
