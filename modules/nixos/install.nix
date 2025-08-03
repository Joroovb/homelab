{pkgs, ...}: let
  installScript = pkgs.writeShellApplication {
    name = "install";

    runtimeInputs = [
      pkgs.ssh-to-age
    ];

    text = ''
      # Define disk
      DISK="/dev/nvme0n1"
      DISK_BOOT_PARTITION="/dev/nvme0n1p1"
      DISK_ROOT_PARTITION="/dev/nvme0n1p2"

      # Undo any previous changes if applicable
      set +e
      umount -R /mnt
      set -e

      # Partitioning disk
      parted $DISK -- mklabel gpt
      parted $DISK -- mkpart ESP fat32 1MiB 512MiB
      parted $DISK -- set 1 boot on
      parted $DISK -- mkpart Nix 512MiB 100%

      # Creating filesystems
      mkfs.fat -F32 -n boot $DISK_BOOT_PARTITION
      mkfs.ext4 -L nix -m 0 $DISK_ROOT_PARTITION

      # Let mkfs catch its breath
      sleep 2

      # Mounting filesystems
      mount /dev/disk/by-label/nix /mnt
      mkdir -p /mnt/boot
      mount /dev/disk/by-label/boot /mnt/boot

      # Generating initrd SSH host key
      mkdir -p /mnt/nix/secret/initrd
      ssh-keygen -t ed25519 -N "" -C "" -f /mnt/nix/secret/initrd/ssh_host_ed25519_key

      # Creating public age key for sops-nix
      ssh-to-age -i /mnt/nix/secret/initrd/ssh_host_ed25519_key.pub
    '';
  };
in {
  config.packages.installScript = installScript;
}
