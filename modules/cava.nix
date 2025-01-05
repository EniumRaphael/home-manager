{ inputs, config, pkgs, ... }:

{
	programs.cava = {
		enable = true;
		settings = {
			general = {
				framerate = 60;
				bars = 7;
			};
			smoothing.noise_reduction = 60;
			color = {
				background = "'#24273a'";
				foreground = "'#c6a0f6'";
			};
		};
	};
}
