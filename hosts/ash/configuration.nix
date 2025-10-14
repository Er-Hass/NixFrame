{ config, pkgs, ... }:
{
  networking.hostName = "ash";   # change per machine
  time.timeZone = "Europe/Berlin";

  # Users will be declared via HM; still need the user on the system:
  users.users.axon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Import per-host bits here later (disks, NVIDIA toggles if needed).
}
