{ self, inputs, ... }: {
  flake.nixosModules.vmConfiguration = { pkgs, lib, ... }: {
    imports =
      [
        self.nixosModules.vmHardware
        self.nixosModules.boot
        self.nixosModules.greetd
        self.nixosModules.nh
        self.nixosModules.niri
        self.nixosModules.fonts

        self.nixosModules.ssh
        self.nixosModules.git
        self.nixosModules.jujutsu
        self.nixosModules.fastfetch
        self.nixosModules.btop
        self.nixosModules.kitty
        self.nixosModules.yazi
        self.nixosModules.vscode

        self.nixosModules.brave
        self.nixosModules.gimp
        self.nixosModules.telegram
      ];

    # Networking
    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

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
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

    security.sudo.execWheelOnly = true;

    nix.settings = {
      trusted-users = [ "sahara_surfer" ];  # Allows to add cache servers
      experimental-features = [ "nix-command" "flakes" ];  
    };

    system.stateVersion = "26.05";
  };
}
