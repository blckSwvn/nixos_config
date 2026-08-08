{ pkgs, unstablePkgs, ... } : {
  environment.systemPackages = with pkgs; [
    wineWow64Packages.full
    typst
    tinymist
    typstyle
    zathura
    starship
    bash
    waypaper
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
    ruff
    basedpyright
    python3Packages.dbus-python
    gdb
    tmux
    firefox
    yt-dlp
    mpv
    libreoffice
    opam
    perl
    dune
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    man-pages
    emacs
    signal-desktop
  ] ++ (with unstablePkgs; [
    librewolf
    i2p
    ]);

  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.blex-mono
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
  programs.obs-studio = {
  enable = true;
  enableVirtualCamera = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

  plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
     obs-pipewire-audio-capture
         ];
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

  programs.nix-ld.enable = true;
}
