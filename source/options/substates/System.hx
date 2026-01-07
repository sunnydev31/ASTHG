/**
	Sunnydev31 - 2025-12-22
	You are allowed to use, modify and redistribute this code
	But give credit where credit is due!
**/

package options.substates;

class System extends OptionsSubState {
	public function new() {
		var opt:Option;

		opt = new Option("cache on gpu", "cacheOnGPU");
		addOption(opt);

		#if DISCORD_ALLOWED
		opt = new Option("discord_rich_presence", "discordRPC");
		addOption(opt);
		#end

		opt = new Option("haptics", "haptics");
		addOption(opt);
		super();
	}
}