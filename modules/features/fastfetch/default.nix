{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.fastfetch
    ];
  };

  perSystem = { pkgs, lib, ... }: 
  let
    /*
    Fastfetch is looking for `liblua5.4.so`, but there is only `liblua.so.5.4`,
    `liblua.so.5.4.7` and `liblua.so`. To avoid "Lua init error" the symlink
    is created below. 
    */
    lua54 = pkgs.symlinkJoin {
      name = "lua-5.4-compat";
      paths = [ pkgs.lua5_4 ];
      postBuild = ''
        ln -s ${pkgs.lua5_4}/lib/liblua.so.5.4 $out/lib/liblua5.4.so
      '';
    };

    /*
    It seems that enlightenment.efl depends on lua 5.2.4 which conflicts
    with explicitly defined lua 5.4.7 needed for scripts' support. The
    solution is to disable enlightenment that I don't need anyways.
    */
    fastfetchUnwrappedLua = pkgs.fastfetch-unwrapped.overrideAttrs (oldAttrs: {
      buildInputs = 
      let
        old = oldAttrs.buildInputs;
        filteblue = builtins.filter (dep: dep != pkgs.enlightenment.efl) old;
      in
        filteblue ++ [ lua54 ];

      cmakeFlags = oldAttrs.cmakeFlags ++ [ 
        (lib.cmakeBool "ENABLE_LUA" true)
      ];
    });

    fastfetchLua = pkgs.fastfetch.override {
      fastfetch-unwrapped = fastfetchUnwrappedLua;
      extraRuntimeDependencies = [ lua54 ];
      enlightenmentSupport = false;
    };

    /*
    Fastfetch's `display.key.width` doesn't allow to choose padded modules
    so we define our own function for that. 
    */
    keyWidth = 15;
    padKey = str:
      let
        len = lib.stringLength (lib.replaceStrings [ "{icon}" ] [ "X" ] str);
        padCount = keyWidth - len;
        spaces = lib.concatStrings (lib.replicate (lib.max 0 padCount) " ");
      in
        str + spaces; 
  in {
    packages.fastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
      inherit pkgs;
      package = fastfetchLua;

      settings = {
        logo = {
          type = "file";
          source = "${./logo.txt}";
          padding = {
            left = 1;
            right = 1;
          };
        };

        display.separator = "";

        modules = [
          {
            type = "title";
            key = "  ";
            keyColor = "blue";
            format = "{#blue}{user-name}@{host-name}";
          }
          {
            type = "custom";
            format = "┌───────────────────────────────────────────┐";
            outputColor = "90";
          }
          {
            type = "os";
            key = padKey "  {icon}  OS";
            keyColor = "blue";
            format = "{name} {version-id}";
          }
          {
            type = "kernel";
            key = padKey "  {icon}  Kernel";
            keyColor = "blue";
            format = "{release}";
          }
          {
            type = "wm";
            key = padKey "  {icon}  DE/WM";
            keyColor = "blue";
            format = "{process-name} {version}";
          }
          {
            type = "terminal";
            key = padKey "  {icon}  Terminal";
            keyColor = "blue";
          }
          {
            type = "shell";
            key = padKey "  {icon}  Shell";
            keyColor = "blue";
          }
          {
            type = "packages";
            key = padKey "  {icon}  Packages";
            keyColor = "blue";
            format = "{all}";
          }
          {
            type = "custom";
            format = "└───────────────────────────────────────────┘";
            outputColor = "90";
          }
          "break"
          {
            type = "host";
            format = "{#green}{name} {version}";
            key = "   ";
            keyColor = "green";
          }
          {
            type = "custom";
            format = "┌───────────────────────────────────────────┐";
            outputColor = "90";
          }
          {
            type = "display";
            key = padKey "  {icon}  Display";
            keyColor = "green";
            format = "{width}x{height} {refresh-rate}Hz";
          }
          {
            type = "cpu";
            key = padKey "  {icon}  CPU";
            keyColor = "green";
            format = "lua:return dofile('${./pretty-cpu.lua}')(...)";
          }
          {
            type = "gpu";
            key = padKey "  {icon}  iGPU";
            keyColor = "green";
            format = "lua:return dofile('${./pretty-igpu.lua}')(...)";
          }
          {
            type = "gpu";
            key = padKey "  {icon}  dGPU";
            keyColor = "green";
            format = "lua:return dofile('${./pretty-dgpu.lua}')(...)";
          }
          {
            type = "disk";
            key = padKey "  {icon}  Disk";
            keyColor = "green";
            format = "{size-used} / {size-total} {size-percentage}";
          }
          {
            type = "memory";
            key = padKey "  {icon}  RAM";
            keyColor = "green";
            format = "{used} / {total} {percentage}";
          }
          {
            type = "custom";
            format = "└───────────────────────────────────────────┘";
            outputColor = "90";
          }
          {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";
          }
        ];
      };
    };
  };
}
