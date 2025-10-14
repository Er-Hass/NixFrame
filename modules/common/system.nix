{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;   # needed for NVIDIA, codecs, etc.

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Audio stack
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.wireplumber.enable = true;

  # Portals (for file pickers / screenshare)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  };

  # Fonts & locale (adjust later if needed)
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  time.timeZone = "Europe/Berlin";

  # Networking
  networking.networkmanager.enable = true;

  # Useful CLI baseline
  environment.systemPackages = with pkgs; [
    vim git ripgrep fd bat eza fzf unzip
  ];

  # Wayland-friendly env (Firefox/Electron etc.)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Enable basic graphics stack (DRM/KMS etc.)
  hardware.graphics.enable = true;
}
