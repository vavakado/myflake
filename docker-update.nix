{ pkgs, ... }:

{
  systemd.services.update-docker = {
    description = "Update Docker containers";
    serviceConfig = {
      Type = "oneshot";
      User = "vavakado";
      ExecStart = "${pkgs.bash}/bin/bash /home/vavakado/docker/default/update-docker.sh";
    };
    path = with pkgs; [
      bash
      docker
    ];
  };

  systemd.timers.update-docker = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };
}
