package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;
import flixel.addons.editors.tiled.*;
import openfl.*;

class Level
{
	public var tilemap:FlxTilemap;
	public var moveGrid:FlxGroup = new FlxGroup();
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
						p.y <= unit.location.y + unit.ap) a.push(p);
			}

			return a;
		}

		function pointsEqiv(p1:FlxPoint, p2:FlxPoint):Bool {
			if (p1.x == p2.x && p1.y == p2.y) return true;
			return false;
		}

		function isVisited(point:FlxPoint, map:Map<FlxPoint, FlxPoint>):Bool {
			for (p in map.keys()) if (pointsEqiv(point, p)) return true;
			return false;
		}

		var start:FlxPoint = FlxPoint.get(Std.int(unit.location.x), Std.int(unit.location.y));
		var frontier:Array<FlxPoint> = [];
		var cameFrom:Map<FlxPoint, FlxPoint> = new Map();
		frontier.push(start);
		cameFrom.set(start, null);

		while (frontier.length > 0) {
			var current:FlxPoint = frontier.shift();

			for (next in getConnected(current)) {
				if (!isVisited(next, cameFrom)) {
					frontier.push(next);
					cameFrom.set(next, current);
				}
			}
		}

		var validMoves:Array<FlxPoint> = [];
		for (p in cameFrom.keys()) {
			var steps:Int = 0;
			var nextFrom:FlxPoint = p;

			while (nextFrom != null) {
				nextFrom = cameFrom.get(nextFrom);
				steps++;
			}

			if (steps <= unit.ap) validMoves.push(p);
		}

		for (p in validMoves) {
			var tile:FlxSprite = new FlxSprite();
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x880000FF);
			tile.x = p.x * Reg.TILE_SIZE;
			tile.y = p.y * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}

		// current = goal
		// 	path = [current]
		// 	while current != start:
		// 		current = came_from[current]
		// 			path.append(current)
		// 			path.reverse()

		// for (p in visited) p.put();
		//todo: free all
	}
}
