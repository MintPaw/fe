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
import comps.*;

class Level
{
	public var tilemap:FlxTilemap = new FlxTilemap();
	public var moveGrid:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	public var playerSpawn:FlxPoint = new FlxPoint();
	public var entities:Array<Entity> = [];
	public var validMovePoints:Array<IntPoint> = [];

	private var _allPoints:Array<IntPoint> = [];
	private var _startGraph:IntPoint;
	private var _cameFromGraph:HashTable<IntPoint, IntPoint> = new HashTable(128);

	public function new(data:String, graphicPath:String) {
		var tiledMap:TiledMap = new TiledMap(data);
		var tileGraphic:FlxTileFrames =
			FlxTileFrames.fromRectangle(
					graphicPath,
					new FlxPoint(Reg.TILE_SIZE, Reg.TILE_SIZE), new FlxRect(1, 1, 101, 67), new FlxPoint(2, 2));

		tilemap.loadMapFromCSV(cast(tiledMap.getLayer("main"), TiledTileLayer).csvData, tileGraphic, 32, 32, null, 1);

		for (obj in cast(tiledMap.getLayer("obj"), TiledObjectLayer).objects) {
			var entity:Entity = new Entity();
			entity.addComp("comps.ItemC");
			entity.addComp("comps.MoveC");
			entity.addComp("comps.RenderC");
			entity.addComp("comps.StatC");
			if (obj.properties.get("controllable") == "1") entity.addComp("comps.ControlC");
			entity.name = obj.name;
			entity.getComp("MoveC").warpToTile(Std.int(obj.x/Reg.TILE_SIZE), Std.int(obj.y/Reg.TILE_SIZE));
			entities.push(entity);
		}

		for (i in 0...tilemap.widthInTiles)
			for (j in 0...tilemap.heightInTiles)
				_allPoints.push(new IntPoint(i, j));
	}

	public function createMoveGrid(entity:Entity):Void {
		validMovePoints = [];
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
						p.x >= entity.getComp("MoveC").location.x - entity.getComp("StatC").ap &&
						p.x <= entity.getComp("MoveC").location.x + entity.getComp("StatC").ap &&
						p.y >= entity.getComp("MoveC").location.y - entity.getComp("StatC").ap &&
						p.y <= entity.getComp("MoveC").location.y + entity.getComp("StatC").ap) a.push(p);
			}

			return a;
		}

		_startGraph = getPoint(entity.getComp("MoveC").location.x, entity.getComp("MoveC").location.y);
		var frontier:PriorityQueue<IntPoint> = new PriorityQueue<IntPoint>(128);
		_startGraph.priority = 0;
		frontier.enqueue(_startGraph);

		var costSoFar:HashTable<IntPoint, Int> = new HashTable(128);
		costSoFar.set(_startGraph, 0);
		
		_cameFromGraph.set(_startGraph, null);
		while (frontier.size > 0) {
			var current:IntPoint = frontier.back();
			frontier.remove(current);

			for (next in getConnected(current)) {
				var newCost:Int = costSoFar.get(current) + getCost(next);
				if ((!costSoFar.hasKey(next) || newCost < costSoFar.get(next)) && newCost <= entity.getComp("StatC").ap) {
					costSoFar.set(next, newCost);
					next.priority = newCost;
					if (!frontier.contains(next)) frontier.enqueue(next);
					if (_cameFromGraph.hasKey(next)) _cameFromGraph.remap(next, current) else _cameFromGraph.set(next, current);
				}
			}
		}

		// Walk graph
		validMovePoints = _cameFromGraph.toKeyArray();

		for (p in validMovePoints) {
			var tile:FlxSprite = moveGrid.recycle(FlxSprite);
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x880000FF);
			tile.x = p.x * Reg.TILE_SIZE;
			tile.y = p.y * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}

		// todo: correct ap distance
	}

	public function findPath(goal:IntPoint):Path {
		var current:IntPoint = getPoint(goal.x, goal.y);

		var path:Array<IntPoint> = [current];
		while (!current.equals(_startGraph)) {
			current = _cameFromGraph.get(current);
			path.push(current);
		}

		path.pop();
		path.reverse();

		var truePath:Path = {path:path, costs:[]};
		for (p in path) truePath.costs.push(getCost(p));
		return truePath;
	}

	private function getPoint(x:Float, y:Float):IntPoint {
		for (p in _allPoints) if (p.x == Std.int(x) && p.y == Std.int(y)) return p;
		return null;
	}

	private function getCost(tile:IntPoint):Int {
		if (tilemap.getTile(tile.x, tile.y) == 1) return 1;
		if (tilemap.getTile(tile.x, tile.y) == 2) return 2;
		if (tilemap.getTile(tile.x, tile.y) == 3) return 3;
		if (tilemap.getTile(tile.x, tile.y) == 4) return 4;
		if (tilemap.getTile(tile.x, tile.y) == 5) return 5;
		return 999;
	}

	public function doneMoving():Void {
		for (m in moveGrid) m.kill();
	}

	public function showPattern(position:IntPoint, action:Action, patternIndex:Int=-1) {
		var patterns:Array<Pattern> = action.patterns;

		if (patternIndex == -1) {
			for (i in 0...patterns.length) addPattern(position, patterns[i]);
		} else {
			doneMoving();
			addPattern(position, patterns[patternIndex]);
		}
	}

	private function addPattern(position:IntPoint, pattern:Pattern):Void {
		for (p in pattern.grid) {
			var tile:FlxSprite = moveGrid.recycle(FlxSprite);
			tile.makeGraphic(Reg.TILE_SIZE, Reg.TILE_SIZE, 0x88FF0000);
			tile.x = (position.x + p.x) * Reg.TILE_SIZE;
			tile.y = (position.y + p.y) * Reg.TILE_SIZE;
			moveGrid.add(tile);
		}
	}
}

typedef Path = {
	path:Array<IntPoint>,
	costs:Array<Int>
}
