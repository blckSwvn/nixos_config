{ config, pkgs, ... } : {

	home.file.".config/mpv" = {
		source = ./config;
		recursive = true;
	};

	home.packages = with pkgs; [
	(mpv.override {
	    scripts = [ mpvScripts.mpris ];
	  })
  ];
}
