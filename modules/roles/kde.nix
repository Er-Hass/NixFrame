{ config, pkgs, ... }:
{
  # Display/login manager + Plasma Wayland
  services.xserver.enable = true;                 # keep true even if running Wayland sessions
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # NVIDIA driver (Wayland-capable)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;              # uses NVIDIA open kernel module where supported
    nvidiaSettings = false;   # optional: enable nvidia-settings GUI if you want
    powerManagement.enable = false;   # keep conservative first
  };
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];

  # KDE portal already added in common/system.nix (xdg-desktop-portal-kde)
  # Keep Electron/Firefox Wayland flags in env (already set).
}
