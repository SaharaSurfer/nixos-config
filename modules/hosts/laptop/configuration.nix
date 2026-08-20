{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.laptopConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.hostLaptop

      self.nixosModules.laptopHardware
      self.nixosModules.battery
      self.nixosModules.intel-gpu
      self.nixosModules.nvidia-gpu
      self.nixosModules.boot
      self.nixosModules.greetd
      self.nixosModules.nh
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
      self.nixosModules.niri
      self.nixosModules.fonts

      self.nixosModules.trash

      self.nixosModules.ssh
      self.nixosModules.git
      self.nixosModules.jujutsu

      self.nixosModules.starship
      self.nixosModules.fastfetch
      self.nixosModules.btop
      self.nixosModules.kitty
      self.nixosModules.yazi
      self.nixosModules.vscode

      self.nixosModules.loupe
      self.nixosModules.gimp
      self.nixosModules.mpv

      self.nixosModules.zen-browser
      self.nixosModules.telegram
    ];

    # Networking
    networking.hostName = "Sahara";
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Set your time zone.
    time.timeZone = "Asia/Yekaterinburg";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."sahara_surfer" = {
      isNormalUser = true;
      description = "sahara_surfer";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [];
    };

    security.sudo.execWheelOnly = true;

    nix.settings = {
      trusted-users = ["sahara_surfer"]; # Allows to add cache servers
      experimental-features = ["nix-command" "flakes"];
    };

    system.stateVersion = "26.05";
    home-manager.users.sahara_surfer = {
      home.stateVersion = "26.05";
    };
  };
}
