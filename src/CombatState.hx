package;

import flixel.*;
import flixel.tile.*;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;
import flixel.addons.editors.tiled.*;
import openfl.*;

class CombatState extends FlxState
{
	private var _tilemap:FlxTilemap;

	public function new() {
		super();
	}

	override public function create():Void {
		var tiledMap:TiledMap = new TiledMap("assets/map/test.tmx");
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle("assets/img/tilemap.png", new FlxPoint(32, 32), null, new FlxPoint(5, 5));

		_tilemap = new FlxTilemap();
		_tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);
		add(_tilemap);
	}
}
