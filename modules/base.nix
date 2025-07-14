{ pkgs, lib, config, ... }:
let
readFirst = filenames: builtins.readFile
    (builtins.head (builtins.filter builtins.pathExists filenames));

  sshKey = readFirst [ ~/.ssh/id_ed25519.pub ~/.ssh/id_rsa.pub ];
in
with lib;{
  imports = [
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  ];

  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
    };

    boot.growPartition = true;
    boot.kernelParams = [ "console=ttyS0" ];
    boot.loader.grub.device = "/dev/vda";
    boot.loader.timeout = 0;

    users.users.root.openssh.authorizedKeys.keys = [ sshKey ];

    services.openssh.enable = true;

    system.stateVersion = "24.11";
  };
}
