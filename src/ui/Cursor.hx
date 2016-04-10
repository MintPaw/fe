package ui;

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
		if (location.x > Reg.mapWidth - 1) location.x = Reg.mapWidth - 1;
		if (location.y > Reg.mapHeight - 1) location.y = Reg.mapHeight - 1;
		if (location.x <= 0) location.x = 0;
		if (location.y <= 0) location.y = 0;

		this.x = location.x * Reg.TILE_SIZE - width/2 - 5;
		this.y = location.y * Reg.TILE_SIZE + Reg.TILE_SIZE/2 - height/2 + 7;
	}

}
