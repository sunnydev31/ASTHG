/**
	Sunnydev31 - 2025-12-22
	You are allowed to use, modify and redistribute this code
	But give credit where credit is due!
**/

package framework;

import flixel.FlxSprite;
import flixel.addons.display.FlxSliceSprite;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;

/**
	Custom instance for FlxSprite with better functions

	Example:	
	```haxe
	var mySprite:AsthgSprite = new AsthgSprite();
	mySprite.create("My Sprite"); // calls `loadGraphic(Paths.image("My Sprite"));`
	```
**/
class AsthgSprite extends FlxSprite {

	public function new(?x:Float = 0, ?y:Float = 0.0, ?image:Null<String>) {
		super(x, y);
	}

	/**
		Creates a simple sprite
		@param pos Position of the sprite
		@param image The image to load
		@return AsthgSprite
	**/
	public static function create(x:Float = 0, y:Float = 0, image:Null<String>):AsthgSprite {
		var spr:AsthgSprite;

		if (!StringUtil.isNull(image)) spr.loadGraphic(x, y, Paths.image(image));
		else {
			trace("[create] 'image' argument is null!");
			spr.loadGraphic(flixel.system.FlxAssets.getBitmapData("flixel/images/logo/default"));
		}

		return spr;
	}

	public static function createSpriteSheet(x:Float = 0, y:Float = 0, fWidth:Int, fHeight:Int, image:Null<String>):AsthgSprite {
		var spr:AsthgSprite = new AsthgSprite(x, y);

		if (!StringUtil.isNull(image))
			spr.loadGraphic(Paths.image(image), true, fWidth, fHeight);
		else {
			trace("[create] 'image' argument is null!");
			spr.loadGraphic(flixel.system.FlxAssets.getBitmapData("flixel/images/logo/default"));
		}

		return spr;
	}

	/**
		Create a new SparrowAtlas V2 sprite.
		@param x Horizontal position.
		@param y Vertical position
		@param image Image name
		@return AsthgSprite
	**/
	public static function createSparrow(x:Float = 0, y:Float = 0, image:String = null):AsthgSprite {
		var spr:AsthgSprite = new AsthgSprite(x, y);

		if (!StringUtil.isNull(image)) {
			spr.frames = Paths.getSparrowAtlas(image);
		}
		else {
			trace("[createSparrow] 'image' argument is null!");
			spr.loadGraphic(flixel.system.FlxAssets.getBitmapData("flixel/images/logo/default"));
		}

		return spr;
	}

	// Just calls FlxGradient, lol
	public static function createGradient(width:Int, height:Int, ?colors:Array<FlxColor>, ?chuncks:UInt = 2, ?angle:Int = 0, ?interp:Bool = true):FlxSprite {
		var spr:FlxSprite = new FlxSprite(); // We need to use FlxSprite here because FlxGradient returns that
		spr = FlxGradient.createGradientFlxSprite(width, height, colors, chuncks, angle, interp);
		return spr;
	}

	public function createGraphic(x:Float = 0, y:Float = 0, width:Float = 1, height:Float = 1, color:FlxColor = FlxColor.WHITE):AsthgSprite {
		var graph:FlxGraphic = FlxG.bitmap.create(2, 2, color, false, 'graphic($x,$y,$width,$height)');
		frames = graph.imageFrame;
		scale.set(width / 2, height / 2);
		updateHitbox(); // We can't use our tool because it's not a FlxSprite-type
		return this;
	}
	
	/**
		Switches a global color into a custom color	
		Note that the sprite must be added or loaded to work

		@param pal The colors to replace in order, Must match the length of the for-loop on the function
		@return AsthgSprite
	**/
	public function applyPalette(pal:Array<FlxColor>):AsthgSprite {
		for (i in 0...Constants.PALETTE_OVERRIDE.length) {
			replaceColor(Constants.PALETTE_OVERRIDE[i], pal[i]);
		}

		return this;
	}

	/**
		Scales a sprite to a specific width and height
		@param width The target width
		@param height The target height
		@param updateHitbox Whether to update the hitbox after scaling
		@return AsthgSprite
	**/
	public function scaleSet(width:Float, height:Float, ?updHitbox:Bool = true):Void {
		scale.set(width, height);
		if (updHitbox) updateHitbox();
	}

	/**
		Creates a 9-Sliced Sprite
		@param x Horizontal position.
		@param y Vertical position.
		@param width Width of the final sprite.
		@param height Height of the final sprite.
		@param graphic Graphic to use.
		@param dimensions Slice rect positions
		@return AsthgSprite
	**/
	public function create9Slice(x:Float, y:Float, width:Float, height:Float, graphic:String, dimensions:Array<FlxRect>):AsthgSprite {
		var spr:AsthgSprite = create(x, y, graphic);
		var topL = dimensions[0]; var topC = dimensions[1]; var topR = dimensions[2]; // Top
		var midL = dimensions[3]; var midC = dimensions[4]; var midR = dimensions[5]; // Center
		var botL = dimensions[6]; var botC = dimensions[7]; var botR = dimensions[8]; // Bottom

		topC.x += topL.width;
		topR.x += topC.x + topC.width;

		midC.x += midL.width;
		midR.x += midC.x + midC.width;

		botC.x += botL.width;
		botR.x += botC.x + botC.width;

		midR.y = midC.y = midL.y = topL.y + topL.height + 1;
		botR.y = botC.y = botL.y = midL.y + midL.height + 1;
		
		for (i in 0...9) {
			spr.frame = dimensions[i];
		}

		return spr;
	}

	/**
		Custom function that returns a FlxPoint!
		to not depend on Flixel functions
		@param x Value 1
		@param y Value 2
		@return FlxPoint
	**/
	inline public static function vec2(x:Float, y:Float):FlxPoint {
		return new FlxPoint(x, y);
	}
}