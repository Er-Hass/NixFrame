{ config, pkgs, ... }:
{
  networking.hostName = "ash";
  time.timeZone = "Europe/Berlin";

  # Create the user; HM will configure it.
  users.users.axon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    initialPassword = "1234"; # change on first boot
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

}
