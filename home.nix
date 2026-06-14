{...} : {

  imports = [
    ./home/librewolf/librewolf.nix
    ./home/helix/helix.nix
      ./home/fish/fish.nix
      ./home/nvim/nvim.nix
      ./home/kitty/kitty.nix
      ./home/waybar/waybar.nix
      ./home/starship/starship.nix
      ./home/river/river.nix
  ];


xdg.desktopEntries = {
  librewolf-no-vpn = {
    name = "Librewolf (no VPN)";
    exec = "mullvad-exclude librewolf";
    icon = "librewolf";
  };

  steam-no-vpn = {
    name = "Steam (no VPN)";
    exec = "env DRI_PRIME=0 mullvad-exclude steam %U";
    icon = "steam";
  };

  steam = {
    name = "Steam";
    exec = "env DRI_PRIME=0 steam %U";
    icon = "steam";
  };

  prism-no-vpn = {
    name = "Prism Launcher (no VPN)";
    exec = "mullvad-exclude prismlauncher";
    icon = "prismlauncher";
  };
};
  home.username = "blckSwan";
  home.homeDirectory = "/home/blckSwan";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
                                      }
