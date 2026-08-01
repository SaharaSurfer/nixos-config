{ inputs, ... }: {
  flake.nixosModules.hjem = {
    imports = [
      inputs.hjem.nixosModules.default
    ];

    hjem = {
      users.sahara_surfer = {
        directory = "/home/sahara_surfer";
        user = "sahara_surfer";
      };

      clobberByDefault = true;
    };
  };
}
