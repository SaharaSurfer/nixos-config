{ self, inputs, ... }: {
  flake.nixosModules.btop = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.btop
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.btop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;
      settings = {
        color_theme = "everforest-dark-medium";
        graph_symbol = "block";

        proc_per_core = true;
        mem_graphs = false;
        show_io_stat = false;
      };
    };
  };
}
