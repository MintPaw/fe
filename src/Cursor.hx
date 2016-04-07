package ;

import flixel.*;
import flixel.math.*;

class Cursor extends FlxSprite
{
	public var location:FlxPoint;
	
	public function new() {
		super();

		location = new FlxPoint();

		loadGraphic("assets/img/cursor.png");
	}

}
