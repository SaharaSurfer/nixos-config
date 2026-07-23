{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    boot-wars-grub.url = "github:SaharaSurfer/boot-wars-grub";
    boot-wars-plymouth.url = "github:SaharaSurfer/boot-wars-plymouth";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}
