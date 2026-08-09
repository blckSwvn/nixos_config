{ config, pkgs, ... } : {

	home.file.".config/fuzzel" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
		fuzzel
	];
}
