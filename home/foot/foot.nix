{ config, pkgs, ... } : {

	home.file.".config/foot" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
    foot
	];
			}
