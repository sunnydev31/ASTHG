package util;

class SystemUtil {
	inline public static function openFolder(folder:String, absolute:Bool = false) {
		#if sys
		if(!absolute) folder =  Sys.getCwd() + folder;

		folder = folder.replace('/', '\\');
		if(folder.endsWith('/'))  older.substr(0, folder.length - 1); 

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

	inline public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}
}