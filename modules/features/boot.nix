{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      timeout = 30;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;

        device = "nodev";

        timeoutStyle = "menu";
        gfxmodeEfi = "1920x1080x32";
        gfxpayloadEfi = "keep";

        configurationLimit = 3;

        # A way to place menuentry at the end
        extraInstallCommands = ''
          echo '
          menuentry "Power off" {
            halt
          }' >> /boot/grub/grub.cfg
        '';

        theme = let
          system = pkgs.stdenv.hostPlatform.system;
          themePkgs = inputs.boot-wars-grub.packages.${system};
          themeName = "rebel_hangar";
        in
          "${themePkgs.${themeName}}/theme";
      };
    };

    boot.kernelParams = [
     "quiet"
     "splash"
     "loglevel=3"
     "udev.log-priority=3"
     "video=1920x1080"
    ];

    boot.plymouth = {
      enable = true;
      theme = "boot-wars";

      themePackages = let
        system = pkgs.stdenv.hostPlatform.system;
      in
        [
          (inputs.boot-wars-plymouth.packages.${system}.default.override {
            tipText = "Experiment without fear of failure. Apply " +
              "changes using 'nh os switch' and remove old " +
              "generations with 'nh clean all'.";
          })  
        ];      
    };
  };
}
