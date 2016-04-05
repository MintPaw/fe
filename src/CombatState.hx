package;

import flixel.*;
import flixel.tile.*;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;
import openfl.*;

class CombatState extends FlxState
{
	private var _tilemap:FlxTilemap;
	
	public function new() {
		super();
	}

	override public function create():Void {
		var mapWidth:Int = 32;
		var mapHeight:Int = 32;

		var mapArray:Array<Array<Int>> = [];
		for (i in 0...mapHeight) {
			var tmp:Array<Int> = [];
			for (j in 0...mapWidth) tmp.push(0);
			mapArray.push(tmp);
		}

		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle("assets/img/tilemap.png", new FlxPoint(32, 32), null, new FlxPoint(5, 5));

		_tilemap = new FlxTilemap();
		_tilemap.loadMapFrom2DArray(mapArray, tileGraphic, 32, 32, null, 1);
		add(_tilemap);
	}
}
