{pkgs, ... }:{
	programs.river = {
enable = true;
extraPackages = with pkgs; [swaylock foot wmenu light yambar ];
};
}
