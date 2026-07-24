{ inputs, ... }: {
  perSystem = { system, ... }: {
    packages.noctalia = inputs.noctalia.packages.${system}.default;
  };
}
