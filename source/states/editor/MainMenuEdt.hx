package states.editor;

class MainMenuEdt extends StateManager {
	var selected:Int = 0;
	var group:FlxTypedGroup<FlxText>;
	var options:Array<String> = [
		"Character Editor"
	];
	
	override public function create() {
		var bg:FlxSprite = AsthgSprite.createGradient(FlxG.width, FlxG.height, [0xFF353535, 0xFF979797], 4, 32, false);
		add(bg);

		
		group = new FlxTypedGroup<FlxText>();
		add(group);

		for (num => str in options) {
			var menu:FlxText = new FlxText(10, 30, 0, Locale.getString("title_" + str, "editor_menu"), 32);
			menu.setFormat(Paths.font("Mania.ttf"), 16, FlxColor.WHITE, "center");
			menu.y += (18 * num);
			menu.ID = num;
			group.add(menu);
		}

		super.create();
		changeItem();
	}

	
	var selectedSomethin:Bool = false;
	override function update(elapsed:Float) {
		if (!selectedSomethin) {
			if (controls.justPressed('up')) {
				changeItem(-1);
				CoolUtil.playSound("MenuChange");
				controls.vibrate(0.5, 0.2, 10);
			}
			if (controls.justPressed('down')) {
				changeItem(1);
				CoolUtil.playSound("MenuChange");
				controls.vibrate(0.5, 0.2, 10);
			}
			if (controls.justPressed('accept')) {
				CoolUtil.playSound("MenuAccept");
				selectedSomethin = true;
				switch(options[selected].toLowerCase()) {
					case 'character editor':
						LoadingState.switchStates(new states.editor.CharacterEditor());
				}
			}
	  		if (controls.justPressed("back")) {
				CoolUtil.playSound("MenuCancel");
				StateManager.switchState(new states.MainMenu());
			}
		}
		super.update(elapsed);
	}

	function changeItem(change:Int = 0) {
		selected = FlxMath.wrap(selected + change, 0, group.length - 1);
		
		group.forEach(function(txt:FlxText) {
			txt.color = (txt.ID == selected) ? 0xFF002896 : 0xFFFFFFFF;
		});
	}
}