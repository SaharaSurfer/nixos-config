{
  flake.nixosModules.trash = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.trash-cli
    ];

    systemd.services."trash-cleanup" = {
      description = "Automatically empty trash older than 7 days";
      script = "${pkgs.trash-cli}/bin/trash-empty 7";
      serviceConfig = {
        Type = "oneshot";
      };
    };

    systemd.timers."trash-cleanup" = {
      description = "Daily trash cleanup timer";
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
