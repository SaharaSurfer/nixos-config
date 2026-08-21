{config, ...}: {
  flake.nixosModules.greetd = {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = config.preferences.user.name;
        };

        default_session = initial_session;
      };
    };
  };
}
