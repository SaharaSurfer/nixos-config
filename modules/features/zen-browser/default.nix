{
  inputs,
  config,
  ...
}: {
  flake.nixosModules.zen-browser = {
    home-manager.users.${config.preferences.user.name} = {
      imports = [inputs.zen-browser.homeModules.beta];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        policies = import ./_policies.nix;
        profiles.default.settings = import ./_settings.nix;
        profiles.default.mods = import ./_mods.nix;
      };
    };
  };
}
