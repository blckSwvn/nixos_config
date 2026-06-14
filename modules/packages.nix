{ pkgs, unstablePkgs, ... } : {

  #packages
  environment.systemPackages = with pkgs; [
    cmus
    starship
    bash
    waypaper
    bat
    git
    btop
    ripgrep
    parted
    gnumake
    fzf
    vlc
    # wineWowPackages.full
    powertop
    cowsay
    fortune
    torsocks
    tor-browser
    qbittorrent
    brightnessctl
    tldr
    man-pages
    liburing
    xwayland
    waylock
    swaybg
    playerctl
    wl-clipboard
    grim
    slurp
    clang-tools
    lua-language-server
    nixd
    nixfmt
    vscode-langservers-extracted
    gcc
    rust-analyzer
    rustfmt
    cargo
    qemu
    quickemu
    direnv
    nix-direnv
    prismlauncher
    fastfetch
    foot
    mullvad
    mullvad-vpn
    python3
    python3Packages.dbus-python
  ] ++ (with unstablePkgs; [
    i2p
    ]);

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.meslo-lg
  ];

  #fonts.packages = [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "esc";
        };
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = false;
    gamescopeSession.enable = true;
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  #for dynamic linking
  programs.nix-ld.enable = true;
}
