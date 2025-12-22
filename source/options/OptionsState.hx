package options;

class OptionsState extends StateManager {
	var options:Array<String> = [
		"System",
		"Display",
		"Gameplay",
		"Controls"
		#if TRANSLATIONS_ALLOWED , "Language" #end
	];
	private var curSelected:Int = 0;
	private var grpTabs:FlxTypedGroup<FlxBitmapText>;

	public static var onPlayState:Bool = false;

	override function create() {
		var bg:FlxSprite = AsthgSprite.createGradient(FlxG.width, FlxG.height, [0x4FFFFFFF, 0x28FFFFFF], 2, 37, false);
		add(bg);

		// tabs group
		grpTabs = new FlxTypedGroup<FlxBitmapText>();
		add(grpTabs);

		for (num => str in options) {
			var txt:FlxBitmapText = new FlxBitmapText(0, 0, Locale.getString("title_" + str, "options"), Paths.getAngelCodeFont("Roco"));
			txt.screenCenter();
			txt.y += (20 * (num - (options.length / 2)));
			txt.screenCenter(X);
			grpTabs.add(txt);
		}

		updateTabVisuals();

		super.create();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.justPressed('up')) {
			changeSelection(-1);
			CoolUtil.playSound("MenuChange");
		} else if (controls.justPressed('down')) {
			changeSelection(1);
			CoolUtil.playSound("MenuChange");
		}

		if (controls.justPressed('accept')) {
			openSelectedSubstate(options[curSelected]);
		}

		if (controls.justPressed('back')) {
			ClientPrefs.saveSettings();
			CoolUtil.playSound("MenuCancel");
			StateManager.switchState(new states.MainMenu());
		}
	}

	private function updateTabVisuals():Void {
		for (idx => t in grpTabs.members) {
			t.color = (idx == curSelected) ? FlxColor.YELLOW : FlxColor.WHITE;
		}
	}

	function changeSelection(change:Int) {	
		curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);
		updateTabVisuals();
	}

	function openSelectedSubstate(lbl:String) {
		switch (lbl.toLowerCase()) {
			case "system": openSubState(new options.substates.System()); CoolUtil.playSound("MenuAccept");
			case "display": openSubState(new options.substates.Display()); CoolUtil.playSound("MenuAccept");
			case "gameplay": openSubState(new options.substates.Gameplay()); CoolUtil.playSound("MenuAccept");
			case "controls": openSubState(new options.substates.Controls()); CoolUtil.playSound("MenuAccept");
			case "language": openSubState(new options.substates.Language()); CoolUtil.playSound("MenuAccept");
			default: trace('Unknown option: "$lbl"'); CoolUtil.playSound("Fail"); return; 
		}
	}

	override function destroy() {
		super.destroy();
	}
}