{ config, pkgs, ... }:
{
  networking.hostName = "ash";
  time.timeZone = "Europe/Berlin";

  # Create the user; HM will configure it.
  users.users.axon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Bootloader choice happens at install time; leave default here.
  # Dual-boot safety: we’ll keep Windows’ EFI intact during install.

  # Import anything per-host later (monitors, disks, GPU quirks).
}
