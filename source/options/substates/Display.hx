/**
	Sunnydev31 - 2025-12-22
	You are allowed to use, modify and redistribute this code
	But give credit where credit is due!
**/

package options.substates;

class Display extends OptionsSubState {
	public function new() {
		var option:Option;

		option = new Option("background_layers", "backLayers", FLOAT, {min:0.0, max:1.0, amount:0.1, display:"%v"});
		addOption(option);

		option = new Option("show_fps", "showFPS");
		addOption(option);

		#if cpp
		option = new Option("framerate", "framerate", INT, {min:60, max:240, amount:1, display:"%v FPS"});
		addOption(option);
		#end

		option = new Option("low_quality", "lowQuality");
		addOption(option);
		super();
	}
}
