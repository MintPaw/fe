package ;

import flixel.*;

class DisplayTile extends FlxSprite
{
	public static var NONE:Int = 0;
	public static var MOVE:Int = 1;
	public static var TARGET:Int = 2;

	public var type:Int

	public function new(type:Int) {
		super();

		this.type = type;
		if (type == MOVE) makeGraphic(0x880000FF);
		if (type == TARGET) makeGraphic(0x88FF0000);
	}

}
