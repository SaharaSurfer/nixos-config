{
  flake.nixosModules.greetd = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "niri-session";
          user = "sahara_surfer";
        };

        default_session = initial_session;
      };
    };
  };
}
