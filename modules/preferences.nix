{lib, ...}: {
  options.preferences = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "sahara_surfer";
        description = "System username";
      };

      gitName = lib.mkOption {
        type = lib.types.str;
        default = "SaharaSurfer";
        description = "Git/JJ author name";
      };

      email = lib.mkOption {
        type = lib.types.str;
        default = "topbo3abp@gmail.com";
        description = "Git/JJ author email";
      };
    };
  };
}
