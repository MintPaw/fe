package;

import flixel.*;
import flixel.group.*;

class MenuFrame extends FlxGroup
{
	private var _bg:FlxSprite;

	public function new() {
		super();
		var padLR:Int = 10;
		var padUD:Int = 10;

		var frameWidth:Int = Std.int(FlxG.width * 0.25 - padLR*2);
		var frameHeight:Int = Std.int(FlxG.height * 0.66 - padUD*2);

		_bg = new FlxSprite();
		_bg.x = padLR;
		_bg.y = padUD;
		_bg.makeGraphic(frameWidth, frameHeight, 0xFF000000);
		add(_bg);
	}

}
