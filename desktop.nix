# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

services.undervolt.enable = true;
services.undervolt.coreOffset = -90;
services.undervolt.analogioOffset = -80;
services.undervolt.gpuOffset = -90;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/vavakado/flakey";
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  #  services.xserver.desktopManager.pantheon.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  services.tlp = {
    enable = true;
  };
  services.thermald.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
		go
		spotify
    tmux
    rustup
		nixfmt
    dwarfs
    btop
    wofi
    foot
    pavucontrol
    anki-bin
    telegram-desktop
    libinput
    htop
    waybar
	nemo-with-extensions
    btop
		nixd
    swaybg
    neovide
		brightnessctl
fastfetch
blueberry
zathura
elixir
elixir-ls
mpv
    vesktop
    swaybg
    mako
    ripgrep
    fd
    grim
    slurp
    tealdeer
    clang
    wl-clipboard
    p7zip
    starship
    zoxide
    fzf
  ];

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;


services.udev.extraRules = ''
SUBSYSTEM=="input", ATTRS{name}=="*Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
'';

  programs.gnupg.agent = {
    enable = true;
  };
}
