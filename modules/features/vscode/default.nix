{
  flake.nixosModules.vscode = {pkgs, ...}: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
      extensions = with pkgs.vscode-extensions;
        [
          ms-python.python
          ms-python.vscode-pylance
          ms-toolsai.jupyter
          ms-toolsai.jupyter-renderers
          jnoortheen.nix-ide
          james-yu.latex-workshop
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "everforest-pro";
            publisher = "andreilucaci";
            version = "2.0.0";
            sha256 = "6AwQzOe9FAsXAQQiPTn/g0PrNc+1v50Ritdy53Py22g=";
          }
        ];
    };

    home-manager.users.sahara_surfer = {
      home.file.".config/Code/User/settings.json".source = ./settings.json;
    };
  };
}
