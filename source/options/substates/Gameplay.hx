/**
	Sunnydev31 - 2025-12-22
	You are allowed to use, modify and redistribute this code
	But give credit where credit is due!
**/

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