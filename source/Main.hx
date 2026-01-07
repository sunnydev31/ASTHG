package;

import flixel.FlxGame;
import firetongue.FireTongue;
import openfl.display.Sprite;

class Main extends Sprite {
	public static var tongue:FireTongue;
	
	public function new() {
		haxe.ui.Toolkit.init();
		haxe.ui.Toolkit.theme = "dark";
		haxe.ui.Toolkit.autoScale = false;
		
		super();
		
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();
		
		tongue = new FireTongue(#if sys VanillaSys #else OPENFL #end, Case.Unchanged);
		
		FlxG.save.bind('game', CoolUtil.getSavePath());
		
		#if MODS_ALLOWED
		Mods.loadMods();
		#end
		
		var game:FlxGame = new FlxGame(0, 0, states.Init, #if (flixel < "5.0.0") 1, #end 60, 60, true);
		
		addChild(game);
	}
	
	public static function onCrash(e:openfl.events.UncaughtErrorEvent) {
		final folderPath:String = "./crash/";
		var date:String = DateTools.format(Date.now(),
			Locale.getString("format_date", null, ["-", "-"]) + "_" + Locale.getString("format_hour", null, ["-", "-"]));
			
		var msg:String = "Error!\n";
		
		msg += e.error + "\n\nReport this in Github: https://github.com/sunkydunky31/ASTHG/issues";
		
		if (!sys.FileSystem.exists(folderPath))
			sys.FileSystem.createDirectory(folderPath);
			
		sys.io.File.saveContent(folderPath + 'ASTHG_${date}.log', msg);
		
		Sys.println(msg);
		
		lime.app.Application.current.window.alert(msg, "Something is wrong...");
		
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		
		Sys.exit(1);
	}
}
