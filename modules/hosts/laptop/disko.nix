{
  flake.diskoConfigurations.hostLaptop = {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL2512HCJQ-00B00_S675NX0T258173";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };

      lvm_vg = {
        pool = {
          type = "lvm_vg";
          lvs = {
            swap = {
              size = "8G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              size = "100%FREE";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
