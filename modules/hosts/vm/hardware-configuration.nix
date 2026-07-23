{ self, inputs, ... }: {
  flake.nixosModules.vmHardware = { config, lib, pkgs, modulesPath, ... }: {
    imports =
      [ (modulesPath + "/profiles/qemu-guest.nix")
      ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/e3aee9d1-5806-419c-adc8-407d5345d287";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/F484-2C74";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/c849101b-5463-45b2-8272-c41fde2886cb"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
