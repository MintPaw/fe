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

	public function moveTo(x:Int, y:Int):Void {
		location.set(x, y);
		this.x = x * Reg.TILE_SIZE - width/2 - 5;
		this.y = y * Reg.TILE_SIZE + Reg.TILE_SIZE/2 - height/2 + 7;
	}

}
