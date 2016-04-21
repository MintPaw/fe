package ui;

import flixel.*;
import flixel.math.*;

class Cursor extends FlxSprite
{
	public static var align:IntPoint = new IntPoint(-5, 7);

	public var selectedTile:IntPoint;
	public var selectedText:Text = null;
	
	public function new() {
		super();

		selectedTile = new IntPoint();

		loadGraphic("assets/img/cursor.png");
	}

	public function moveTo(x:Int, y:Int):Void {
		selectedTile.set(x, y);
		if (selectedTile.x > Reg.mapWidth - 1) selectedTile.x = Reg.mapWidth - 1;
		if (selectedTile.y > Reg.mapHeight - 1) selectedTile.y = Reg.mapHeight - 1;
		if (selectedTile.x <= 0) selectedTile.x = 0;
		if (selectedTile.y <= 0) selectedTile.y = 0;

		this.x = selectedTile.x * Reg.TILE_SIZE - width/2 + align.x;
		this.y = selectedTile.y * Reg.TILE_SIZE + Reg.TILE_SIZE/2 - height/2 + align.y;
	}

	public function moveToText(text:Text):Void {
		selectedText = text;
		x = text.x - width + align.x;
		y = text.y + text.height/2 - height/2 + align.y;
	}

}
