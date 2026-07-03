{ config, pkgs, ... } : {

	home.file."./" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
    tmux
	];
			}
