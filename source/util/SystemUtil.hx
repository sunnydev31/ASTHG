package util;

class SystemUtil {
	inline public static function openFolder(folder:String, absolute:Bool = false) {
		#if sys
		if(!absolute) folder =  Sys.getCwd() + folder;

		folder = folder.replace('/', '\\');
		if(folder.endsWith('/')) folder.substr(0, folder.length - 1); 

		#if linux
			var command:String = '/usr/bin/xdg-open';
		#elseif windows
			var command:String = 'explorer.exe';
		#end

		#if (windows || linux)
			Sys.command(command, [folder]);
			trace('[openFolder] $command $folder');
		#end
		#else
		FlxG.log.error("Platform is not supported for SystemUtil.openFolder");
		#end
	}

	inline public static function browserLoad(site:String):Void {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	inline public static function getAccentColor():FlxColor {
		var clr:Null<Dynamic>;
		#if (web || flash)
		FlxG.log.error("[ERROR] You're using a platform that doesn't support accent colors!");
		#elseif windows
		var p = new sys.io.Process("powershell.exe", ["-Command",
		"Get-ItemPropertyValue",
		"HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Accent", "AccentColorMenu"]);

		var accent = p.stdout.readLine();
		p.close();

		/*
			We need to transform to HEX and parse substrings because
			Windows accent color is stored as ABRG
		*/

		var hex = StringTools.hex(Std.parseInt(accent), 8);

		var a = hex.substr(6, 2);
		var r = hex.substr(0, 2);
		var g = hex.substr(4, 2);
		var b = hex.substr(2, 2);

		clr = FlxColor.fromString('#$r$g$b');
		#end

		if (clr != null) trace ('Got accent color: clr $clr', "accent" + accent, "hex " + '0x$a$r$g$b', 'hex $hex');
		return clr ?? FlxColor.WHITE;
	}
}