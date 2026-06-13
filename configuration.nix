{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./modules/noveau.nix
    ./modules/nvidia.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/packages.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          qt6Packages.fcitx5-configtool
        ];
        waylandFrontend = true;
      };
    };
  };

  # Configure console keymap
  console.keyMap = "no";

  #user
  programs.fish.enable = true;

  users.users.blckSwan = {
    isNormalUser = true;
    description = "null";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "kvm"
      "input"
    ];
  };

  security.sudo.enable = false;

  security.sudo-rs = {
    enable = true;
  };

  users.users.root = {
    shell = pkgs.fish;
  };

  services.logind.settings.Login = {
    handleLidSwitch = "suspend";
    HandleLidSwitchDocked = "ignore";
    IdleAction = "suspend";
    IdleActionSec = "20min";
  };

  programs.man.enable = true;

  environment.variables = {
    MANPAGER = "nvim +Man!";
    EDITOR = "nvim";
  };

  security.pam.services.waylock = {
    text = ''
      auth    include login
      account include login
    '';
  };

  system.stateVersion = "26.05";
}
