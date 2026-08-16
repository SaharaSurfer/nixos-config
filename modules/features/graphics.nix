{
  flake.nixosModules.graphics = { pkgs, ... }: {
    hardware.nvidia = {
      open = true;

      powerManagement = {
        enable = false;
        finegrained = true;
      };
      
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };

      modesetting.enable = true;
    };

    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
