package;

import flixel.*;
import flixel.tile.*;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;
import flixel.addons.editors.tiled.*;
import openfl.*;

class Level
{
	public var tilemap:FlxTilemap;

	public function new(data:String, graphicPath:String) {
		var tiledMap:TiledMap = new TiledMap(data);
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle(graphicPath, new FlxPoint(32, 32), null, new FlxPoint(5, 5));

		tilemap = new FlxTilemap();
		tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);
	}
}
