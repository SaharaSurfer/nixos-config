{
  flake.nixosModules.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        james-yu.latex-workshop
        shd101wyy.markdown-preview-enhanced
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "everforest-pro";
          publisher = "andreilucaci";
          version = "2.0.0";
          sha256 = "6AwQzOe9FAsXAQQiPTn/g0PrNc+1v50Ritdy53Py22g=";
        }
      ];
    };

    hjem.users.sahara_surfer = {
      files.".config/Code/User/settings.json".source = ./settings.json;
    };
  }; 
}
