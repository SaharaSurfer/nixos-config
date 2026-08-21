{
  flake.nixosModules.battery = {
    services = {
      upower.enable = true;
      thermald.enable = true;
      system76-scheduler = {
        enable = true;
        settings.cfsProfiles.enable = true;
      };

      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };
  };
}
