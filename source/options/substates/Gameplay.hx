package options.substates;

import options.Option;

class Gameplay extends options.OptionsSubState {
	public function new() {
		var option:Option;

		option = new Option("auto_pause", "autoPause");
		addOption(option);
		
		option = new Option("flashing_lights", "flashing");
		addOption(option);
		
		option = new Option("hide_hud", "hideHud");
		addOption(option);
		super();
	}
}