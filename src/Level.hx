package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;
import flixel.addons.editors.tiled.*;
import openfl.*;
import de.polygonal.ds.LinkedQueue;
import de.polygonal.ds.PriorityQueue;
import de.polygonal.ds.HashTable;
import Item;

class Level
{
	public var tilemap:FlxTilemap = new FlxTilemap();
	public var moveGrid:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	public var playerSpawn:FlxPoint = new FlxPoint();
	public var validMovePoints:Array<IntPoint> = [];

	private var _allPoints:Array<IntPoint> = [];
	private var _startGraph:IntPoint = new IntPoint();
	private var _cameFromGraph:HashTable<IntPoint, IntPoint> = new HashTable(128);

	public function new(data:String, graphicPath:String) {
		var tiledMap:TiledMap = new TiledMap(data);
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle(
					graphicPath,
					new FlxPoint(Reg.TILE_SIZE, Reg.TILE_SIZE), new FlxRect(1, 1, 101, 67), new FlxPoint(2, 2));

		tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);

		for (obj in cast(tiledMap.getLayer("obj"), TiledObjectLayer).objects) {
			if (obj.name == "playerSpawn") playerSpawn.set(obj.x/Reg.TILE_SIZE, obj.y/Reg.TILE_SIZE);
		}

		for (i in 0...tilemap.widthInTiles)
			for (j in 0...tilemap.heightInTiles)
				_allPoints.push(new IntPoint(i, j));
	}

	public function createMoveGrid(unit:Unit):Void {
		_cameFromGraph.clear();

		// Create graph
		function getConnected(point:IntPoint):Array<IntPoint> {
			var a:Array<IntPoint> = [];
			var possiblePoints:Array<IntPoint> = [
				getPoint(point.x - 1, point.y), 
				getPoint(point.x + 1, point.y),
				getPoint(point.x, point.y - 1),
				getPoint(point.x, point.y + 1)
			];

			for (p in possiblePoints) {
				if (
						p != null &&
						p.x >= unit.location.x - unit.ap &&
						p.x <= unit.location.x + unit.ap &&
						p.y >= unit.location.y - unit.ap &&
						p.y <= unit.location.y + unit.ap) a.push(p);
			}

			return a;
		}

		_startGraph = getPoint(unit.location.x, unit.location.y);
		var frontier:LinkedQueue<IntPoint> = new LinkedQueue<IntPoint>();
		// var frontier:PriorityQueue<IntPoint> = new PriorityQueue<IntPoint>();
		frontier.enqueue(_startGraph);
		// frontier.reprioritize(_startGraph, 0);

		// var costSoFar:Map<IntPoint, Int> = new Map();
		// costSoFar.set(_startGraph, 0);
		
		_cameFromGraph.set(_startGraph, null);
		while (frontier.size > 0) {
			var current:IntPoint = frontier.dequeue();

			for (next in getConnected(current)) {
				// var newCost:Int = getVal(current, costSoFar) + _cameFromGraph.
				if (!_cameFromGraph.hasKey(next)) {
					frontier.enqueue(next);
					_cameFromGraph.set(next, current);
				}
			}
		}

		// Walk graph
		for (p in _cameFromGraph.keys()) {
			var steps:Int = 0;
			var nextFrom:IntPoint = p;

			while (nextFrom != null) {
				nextFrom = _cameFromGraph.get(nextFrom);
				steps++;
			}

			if (steps <= unit.ap) validMovePoints.push(p);
		}

		for (p in validMovePoints) {
			var tile:FlxSprite = moveGrid.recycle(FlxSprite);
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x880000FF);
			tile.x = p.x * Reg.TILE_SIZE;
			tile.y = p.y * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}

		// todo: correct ap distance
	}

	public function findPath(goal:IntPoint):Array<IntPoint> {
		var current:IntPoint = getPoint(goal.x, goal.y);

		var path:Array<IntPoint> = [current];
		while (!current.equals(_startGraph)) {
			current = _cameFromGraph.get(current);
			path.push(current);
		}

		path.reverse();
		return path;
	}

		private function getPoint(x:Float, y:Float):IntPoint {
			for (p in _allPoints) if (p.x == Std.int(x) && p.y == Std.int(y)) return p;
			return null;
		}

	public function doneMoving():Void {
		for (m in moveGrid) m.kill();
	}

	public function showPattern(unit:Unit, itemId:Int, actionId:Int, patternIndex:Int=-1) {
		var patterns:Array<Pattern> = unit.items[itemId].actions[actionId].patterns;

		if (patternIndex == -1) {
			for (i in 0...patterns.length) addPattern(unit, patterns[i]);
		} else {
			doneMoving();
			addPattern(unit, patterns[patternIndex]);
		}
	}

	private function addPattern(unit:Unit, pattern:Pattern):Void {
		for (p in pattern.grid) {
			var tile:FlxSprite = moveGrid.recycle(FlxSprite);
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x88FF0000);
			tile.x = (unit.location.x + p.x) * Reg.TILE_SIZE;
			tile.y = (unit.location.y + p.y) * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}
	}
}
