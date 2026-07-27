{ inputs, ... }: {
  perSystem = { system, pkgs, ... }: 
  let
    noctaliaPkg = inputs.noctalia.packages.${system}.default;
    noctaliaConfig = pkgs.runCommand "noctalia-config" {} ''
      mkdir -p $out/noctalia
      cp ${./config.toml} $out/noctalia/config.toml
    '';
  in {
    packages.noctalia = pkgs.writeShellScriptBin "noctalia" ''
      export NOCTALIA_CONFIG_HOME="${noctaliaConfig}"
      exec ${noctaliaPkg}/bin/noctalia "$@"
    '';
  };
}
