{ pkgs,lib,config, ... }: {
  systemd = {
    user.services.hyprpolkitagent = {
      description = "hyprpolkitagent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    kitty
    waybar
    wofi
    foot
    firefox
    neovim
    emacs-pgtk
    gcc
    rustup
    nixfmt-rfc-style
    nixd
    sqlite
    imagemagick
    ripgrep
    fd
    wl-clipboard
    tmux
    brightnessctl
    telegram-desktop
    btop
    comma
    blueberry
    swaybg
    grim
    slurp
    mako
    spotify
    nix-index
    powertop
config.boot.kernelPackages.cpupower
		fastfetch
		pwvucontrol
		thunderbird
		sshfs
  ];

  services.logind.lidSwitch = lib.mkForce "suspend";

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };
  programs.steam.enable = true;
  services.thermald.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs;
    [ noto-fonts noto-fonts-cjk-sans noto-fonts-cjk-serif ]
    ++ (builtins.filter lib.attrsets.isDerivation
      (builtins.attrValues pkgs.nerd-fonts));
}
