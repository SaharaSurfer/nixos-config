{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.loupe = {pkgs, ...}: let
    # Choosing "opengl" as a renderer speeds up start up
    loupeWrappedPkg = pkgs.symlinkJoin {
      name = "loupe-wrapped";
      paths = [pkgs.loupe];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/loupe --set GSK_RENDERER opengl
      '';
    };
  in {
    environment.systemPackages = [
      loupeWrappedPkg
    ];

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "image/*" = "org.gnome.Loupe.desktop";
      };
    };
  };
}
