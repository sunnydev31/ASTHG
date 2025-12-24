/**
	Sunnydev31 - 2025-12-22
	You are allowed to use, modify and redistribute this code
	But give credit where credit is due!
**/

package states;

import objects.Character;
import flixel.tween.*;

class SaveSelect extends StateManager {
	public var camFront:FlxCamera;

	public var saveGroup:FlxTypedGroup<SaveEntry>;
	var curSelected:Int = 0;

	var selectSave:AsthgSprite;
	var selectUpZone:AsthgSprite;
	var selectUpChar:AsthgSprite;
	var selectDownZone:AsthgSprite;
	var selectDownChar:AsthgSprite;

	override function create() {
		Paths.clearUnusedMemory();
		Paths.clearStoredMemory();

		saveGroup = new FlxTypedGroup<SaveEntry>();

		#if DISCORD_ALLOWED
		DiscordClient.changePresence(Locale.getString('save_select', 'discord'), null);
		#end

		camFront = new FlxCamera();
		camFront.visible = true;
		camFront.bgColor.alpha = 5;
		FlxG.cameras.add(camFront, false);
		
		var bg:AsthgSprite = new AsthgSprite().createGraphic(FlxG.width, FlxG.height, 0xff4d4dff);
		add(bg);
		
		var bgLayer:AsthgSprite = new AsthgSprite().createGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bgLayer.alpha = ClientPrefs.data.backLayers;
		add(bgLayer);
		
		var title:FlxBitmapText = new FlxBitmapText(FlxG.width/2, FlxG.height - 26, Locale.getString("title", "save_select"), Paths.getAngelCodeFont("GameOver"));
		title.x -= title.width / 2;
		add(title);

		for (i in 0...Constants.SAVE_ENTRY_LIMIT) {
			var saveEntry:SaveEntry = new SaveEntry(i);
			saveEntry.setPosition(90 * i, 50);
			saveEntry.cameras = [camFront];
			saveGroup.add(saveEntry);
		}
		add(saveGroup);

		//Do not touch the position of this sprite
		selectSave = AsthgSprite.create(saveGroup.members[curSelected].x, saveGroup.members[curSelected].y, "saveSelect/selected");
		FlxTween.color(selectSave, 0.2, FlxColor.fromString(Constants.SAVE_SELECTED_FRAME_COLOR[0]), FlxColor.fromString(Constants.SAVE_SELECTED_FRAME_COLOR[1]), {type: FlxTweenType.PINGPONG, ease: FlxEase.linear});
		selectSave.cameras = [camFront];
		add(selectSave);

		// Positions of all the sprites above are updated on `changeSelection()`
		selectUpZone = AsthgSprite.create(0, 0, "saveSelect/selectArrow");
		selectUpZone.color = FlxColor.fromString(Constants.SAVE_SELECTED_ARROW_COLOR[0]);
		selectUpZone.cameras = [camFront];
		add(selectUpZone);

		selectUpChar = AsthgSprite.create(0, 0, "saveSelect/selectArrow");
		selectUpChar.color = FlxColor.fromString(Constants.SAVE_SELECTED_ARROW_COLOR[1]);
		selectUpChar.cameras = [camFront];
		add(selectUpChar);

		selectDownZone = AsthgSprite.create(0, 0, "saveSelect/selectArrowFlip");
		selectDownZone.color = selectUpZone.color;
		selectDownZone.cameras = [camFront];
		add(selectDownZone);

		selectDownChar = AsthgSprite.create(0, 0, "saveSelect/selectArrowFlip");
		selectDownChar.color = selectUpChar.color;
		selectDownChar.cameras = [camFront];
		add(selectDownChar);

		camFront.follow(selectSave, LOCKON, 40);
		changeSelection();

		super.create();
		CoolUtil.playMusic("SaveSelect");
	}

	override function update(e:Float) {
		super.update(e);

		if (controls.justPressed('accept')) {
			LoadingState.switchStates(new states.PlayState(), true);
		}

		if (controls.justPressed('back')) {
			StateManager.switchState(new states.MainMenu());
		}

		if (controls.justPressed('left')) {
			changeSelection(-1);
		} else if (controls.justPressed('right')) {
			changeSelection(1);
		}
	}

	function changeSelection(count:Int = 0) {
		curSelected = FlxMath.wrap(curSelected + count, 0, saveGroup.length - 1);

		var member = cast saveGroup.members[curSelected];
		if (member == null) {
			#if debug trace("[changeSelection] Returned: member is null!"); #end
			return;
		}

		selectSave.setPosition    (member?.x,	   member?.y);
		selectUpChar.setPosition  (selectUpZone.x, member?.y + 65);
		selectDownChar.setPosition(selectUpChar.x, selectUpChar.y + 30);
		selectUpZone.setPosition  (member?.x + 35,  member?.y + 14);
		selectDownZone.setPosition(selectUpZone.x, selectUpZone.y + 18);

		CoolUtil.playSound("MenuChange");
	}
}

class SaveEntry extends FlxSpriteGroup {
	public var character:Character = null;
	public var emeralds:Array<FlxSprite> = new Array<FlxSprite>();
	public function new(id:Int) {
		super();

		var save:AsthgSprite = AsthgSprite.create("saveSelect/save");
		add(save);

		var colors:Array<Array<FlxColor>> = [
			[0xff0080e0, 0xff00b4cc, 0xff00c0e0, 0xff80e0e0],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
			[0xffff0000, 0xffda0000, 0xffae0000, 0xff790000],
		];

		for (i in 0...7) {
			var emerald:AsthgSprite = AsthgSprite.create(2, save.height - 12, "saveSelect/emerald");
			emerald.x += (emerald.width * i) + i;
			add(emerald);
			emerald.applyPalette([colors[i][0], colors[i][1], colors[i][2], colors[i][3]]);
			emeralds.push(emerald);
		}
	}
}