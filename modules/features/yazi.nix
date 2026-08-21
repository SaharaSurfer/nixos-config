{
  self,
  inputs,
  ...
}: {
  # TODO: checkout yaziPlugins.*
  flake.nixosModules.yazi = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.yazi
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      package = pkgs.yazi.override {
        _7zz = pkgs._7zz-rar;
      };

      runtimePkgs = [
        # previews
        pkgs.ffmpeg # video
        pkgs.jq # json
        pkgs.poppler # pdf
        pkgs.resvg # svg
        pkgs.imagemagick # fonts, heic, etc.

        # navigation
        pkgs.fd # file searching
        pkgs.fzf # subtree navigation
        pkgs.zoxide # better cd
        pkgs.ripgrep # file content searching

        # plugin dependencies
        pkgs.trash-cli # omni-trash
      ];

      plugins = {
        omni-trash = pkgs.yaziPlugins.omni-trash;
      };

      settings.keymap.mgr.prepend_keymap = [
        {
          on = ["R"];
          run = "plugin omni-trash";
          desc = "Open Omni Trash";
        }
      ];
    };
  };
}
