{ config, pkgs, ... } : {

	home.file.".config/helix" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
		evil-helix
	];
}
