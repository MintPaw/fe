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
	public var tilemap:FlxTilemap = new FlxTilemap();
	public var moveGrid:FlxGroup = new FlxGroup();

	public var playerSpawn:FlxPoint = new FlxPoint();
	public var validMovePoints:Array<FlxPoint> = [];

	private var _startGraph:FlxPoint = FlxPoint.get();
	private var _cameFromGraph:Map<FlxPoint, FlxPoint> = new Map();

	public function new(data:String, graphicPath:String) {
		var tiledMap:TiledMap = new TiledMap(data);
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle(graphicPath, new FlxPoint(Reg.TILE_SIZE, Reg.TILE_SIZE), null, new FlxPoint(5, 5));

		tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);

		for (obj in cast(tiledMap.getLayer("obj"), TiledObjectLayer).objects) {
			if (obj.name == "playerSpawn") playerSpawn.set(obj.x/Reg.TILE_SIZE, obj.y/Reg.TILE_SIZE);
		}
	}

	public function createMoveGrid(unit:Unit):Void {
		// Destroy old graph
		for (p in _cameFromGraph.keys()) {
			_cameFromGraph.get(p).put();
			p.put();
		}

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

		function isVisited(point:FlxPoint, map:Map<FlxPoint, FlxPoint>):Bool {
			for (p in map.keys()) if (point.equals(p)) return true;
			return false;
		}

		_startGraph = FlxPoint.get(Std.int(unit.location.x), Std.int(unit.location.y));
		var frontier:Array<FlxPoint> = [];
		frontier.push(_startGraph);
		
		_cameFromGraph.set(_startGraph, null);
		while (frontier.length > 0) {
			var current:FlxPoint = frontier.shift();

			for (next in getConnected(current)) {
				if (!isVisited(next, _cameFromGraph)) {
					frontier.push(next);
					_cameFromGraph.set(next, current);
				}
			}
		}

		// Walk graph
		for (p in _cameFromGraph.keys()) {
			var steps:Int = 0;
			var nextFrom:FlxPoint = p;

			while (nextFrom != null) {
				nextFrom = _cameFromGraph.get(nextFrom);
				steps++;
			}

			if (steps <= unit.ap) validMovePoints.push(p);
		}

		for (p in validMovePoints) {
			var tile:FlxSprite = new FlxSprite();
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x880000FF);
			tile.x = p.x * Reg.TILE_SIZE;
			tile.y = p.y * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}

		// todo: test free
		// todo: correct ap distance
	}

	public function findPath(goal:FlxPoint):Array<FlxPoint> {
		var current:FlxPoint = new FlxPoint();

		for (p in _cameFromGraph.keys()) {
			if (goal.equals(p)) {
				current = p;
				break;
			}
		}

		var path:Array<FlxPoint> = [current];
		while (!current.equals(_startGraph)) {
			current = _cameFromGraph.get(current);
			path.push(current);
		}

		path.reverse();
		return path;
	}
}
