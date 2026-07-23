{ inputs, ... }: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = [
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono-nerd      
    ];

    fonts.fontconfig.defaultFonts = {
      sansSerif = [ "SF Pro" ];
      monospace = [ "SFMono Nerd Font" ];
    };
  };
}
