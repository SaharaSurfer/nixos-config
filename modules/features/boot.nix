{inputs, ...}: {
  flake.nixosModules.boot = {pkgs, ...}: {
    boot = {
      loader = {
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
          in "${themePkgs.${themeName}}/theme";
        };
      };

      plymouth = {
        enable = true;
        theme = "boot-wars";

        themePackages = let
          system = pkgs.stdenv.hostPlatform.system;
        in [
          (inputs.boot-wars-plymouth.packages.${system}.default.override {
            tipText =
              "Experiment without fear of failure. Apply "
              + "changes using 'nh os switch' and remove old "
              + "generations with 'nh clean all'.";
          })
        ];
      };

      kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
        "udev.log-priority=3"
        "video=1920x1080"
      ];

      # Some of the security measures described at
      # wiki.nixos.org/wiki/NixOS_Hardening
      # madaidans-insecurities.github.io/guides/linux-hardening.html
      kernel.sysctl = {
        # Loose mode to allow split tunneling
        "net.ipv4.conf.all.rp_filter" = 2;
        "net.ipv4.conf.default.rp_filter" = 2;

        "net.ipv4.conf.all.accept_redirects" = 0;
        "net.ipv4.conf.default.accept_redirects" = 0;
        "net.ipv4.conf.all.secure_redirects" = 0;
        "net.ipv4.conf.default.secure_redirects" = 0;
        "net.ipv6.conf.all.accept_redirects" = 0;
        "net.ipv6.conf.default.accept_redirects" = 0;
        "net.ipv6.conf.all.send_redirects" = 0;
        "net.ipv6.conf.default.send_redirects" = 0;

        "net.ipv4.conf.all.accept_source_route" = 0;
        "net.ipv4.conf.default.accept_source_route" = 0;
        "net.ipv6.conf.all.accept_source_route" = 0;
        "net.ipv6.conf.default.accept_source_route" = 0;
      };
    };
  };
}
