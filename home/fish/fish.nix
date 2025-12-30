{ config, pkgs, ... } : {

  home.file.".config/fish" = {
    source = ./config;
    recursive = true;
  };

#nvim installed directly through flake
  home.packages = with pkgs; [
    fish
  ];
                        }
