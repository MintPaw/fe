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
	public var playerSpawn:FlxPoint = new FlxPoint();

	public function new(data:String, graphicPath:String) {
		var tiledMap:TiledMap = new TiledMap(data);
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle(graphicPath, new FlxPoint(Reg.TILE_SIZE, Reg.TILE_SIZE), null, new FlxPoint(5, 5));

		tilemap = new FlxTilemap();
		tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);

		for (obj in cast(tiledMap.getLayer("obj"), TiledObjectLayer).objects) {
			if (obj.name == "playerSpawn") playerSpawn.set(obj.x/Reg.TILE_SIZE, obj.y/Reg.TILE_SIZE);
		}
	}

	public function createMoveGrid(unit:Unit):Void {
		// Create graph
		function getConnected(point:FlxPoint):Array<FlxPoint> {
			var a:Array<FlxPoint> = [];
			var possiblePoints:Array<FlxPoint> = [
				FlxPoint.get(point.x - 1, point.y), 
				FlxPoint.get(point.x + 1, point.y),
				FlxPoint.get(point.x, point.y - 1),
				FlxPoint.get(point.x, point.y + 1)
			];

			for (p in possiblePoints) {
				if (
						p.x >= 0 &&
						p.x <= tilemap.widthInTiles - 1 &&
						p.y >= 0 &&
						p.y <= tilemap.heightInTiles - 1 &&
						p.x >= unit.location.x - unit.ap &&
						p.x <= unit.location.x + unit.ap &&
						p.y >= unit.location.y - unit.ap &&
						p.y <= unit.location.y + unit.ap
						) a.push(p);
			}

			return a;
		}

		function isVisited(point:FlxPoint, array:Array<FlxPoint>):Bool {
			for (p in array) if (p.x == point.x && p.y == point.y) return true;
			return false;
		}

		var start:FlxPoint = FlxPoint.get(Std.int(unit.location.x), Std.int(unit.location.y));
		var frontier:Array<FlxPoint> = [];
		var visited:Array<FlxPoint> = [];
		frontier.push(start);
		visited.push(start);

		while (frontier.length > 0) {
			var current:FlxPoint = frontier.pop();

			for (next in getConnected(current)) {
				if (!isVisited(next, visited)) {
					frontier.push(next);
					visited.push(next);
				}
			}
		}

		for (p in visited) {
			var f:FlxSprite = new FlxSprite();
			f.makeGraphic(5, 5, 0xFFFF0000);
			f.x = p.x * Reg.TILE_SIZE;
			f.y = p.y * Reg.TILE_SIZE;
			FlxG.state.add(f);
		}
		trace(visited.length);
		// for (p in visited) p.put();
		//todo: free all
	}
}
