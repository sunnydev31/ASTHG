package options;

import options.Option;
import backend.InputFormatter;

class OptionsSubState extends SubStateManager {
	var selected:Int = 0;
	var options:Array<Option>;
	
	var grpOptions:FlxTypedGroup<FlxText>;
	var grpValues:FlxTypedGroup<FlxText>;

	var txtDesc:FlxText;
	var sprDesc:FlxSprite;

	public function new() {
		super();
		var bg = new FlxSprite().makeGraphic(1, 1, 0);
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.alpha = 0.6;
		add(bg);
		
		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		grpValues = new FlxTypedGroup<FlxText>();
		add(grpValues);

		for (i in 0...options.length) {
			var optName:AsthgText = AsthgText.create(40, 10, options[i].flag);
			optName.y += 26 * (i - (options.length / 2));
			grpOptions.add(optName);


			var optValues:AsthgText = AsthgText.create(210, optName.y, Std.string(options[i].value));
			optValues.alignment = "right";
			grpValues.add(optValues);
		}

		sprDesc = new FlxSprite(0, FlxG.height * 0.7).makeGraphic(1, 1, 0);
		sprDesc.setGraphicSize(FlxG.stage.stageWidth, 30);
		sprDesc.updateHitbox();
	}

	override public function update(e:Float) {
		if(controls.justPressed('back')) {
			close(); CoolUtil.playSound('MenuCancel');
		}
	}

	public function addOption(option:Option) {
		if(options == null || options.length < 1) options = [];
		options.push(option);
		return option;
	}
	
	function changeSelection(change:Int = 0) {
		selected = FlxMath.wrap(selected + change, 0, options.length - 1);
	}
}