{
  flake.nixosModules.nvidia-gpu = {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      open = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      /*
      I'm not sure if this is working properly in 26.05, but `prime.offload`
      is required by `powerManagement.finegrained`. For details see
      https://discourse.nixos.org/t/can-we-solve-the-nvidia-situation/73198
      */
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };

      dynamicBoost.enable = true;
    };
  };
}
