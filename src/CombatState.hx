package;

import ui.*;
import flixel.*;
import flixel.FlxCamera;
import flixel.tile.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import flixel.util.*;
import flixel.tweens.*;
import openfl.*;
import Level;

class CombatState extends FlxState
{
	private var _level:Level;
	private var _cursor:Cursor;
	private var _menu:GameMenu;

	private var _unitGroup:FlxTypedGroup<Unit>;
	private var _selectedUnit:Unit = null;

	private var _state:String;

	public function new() {
		super();
	}

	override public function create():Void {
		_level = new Level("assets/map/test.tmx", "assets/img/tilemap.png");
		Reg.mapWidth = _level.tilemap.widthInTiles;
		Reg.mapHeight = _level.tilemap.heightInTiles;
		Reg.level = _level;
		add(_level.tilemap);
		add(_level.moveGrid);

		_unitGroup = new FlxTypedGroup<Unit>();

		for (u in _level.units) _unitGroup.add(cast add(u));

		// var p = new Unit();
		// p.getNewItem(0);
		// p.controllable = true;
		// p.warp(cast _level.playerSpawn.x, cast _level.playerSpawn.y);
		// _unitGroup.add(p);
		// add(p);

		_cursor = new Cursor();
		for (u in _unitGroup) {
			if (u.controllable) {
				_cursor.moveTo(cast u.location.x, cast u.location.y);
				break;
			}
		}
		add(_cursor);

		_state = "select";
		FlxG.camera.setScrollBoundsRect(0, 0, _level.tilemap.width, _level.tilemap.height, true);
		FlxG.camera.follow(_cursor, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.antialiasing = true;

		Text.loadFont("default0", "assets/font/default0.png", "assets/font/default0.fnt");
		Text.loadFont("default1", "assets/font/default1.png", "assets/font/default1.fnt");
		Text.loadFont("default2", "assets/font/default2.png", "assets/font/default2.fnt");
		Text.loadFont("default3", "assets/font/default3.png", "assets/font/default3.fnt");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (_menu != null && _menu.enabled) return;

		var nextTile:IntPoint = new IntPoint();
		var oldTile:IntPoint = new IntPoint();

		if (_state == "select" || _state == "move") {
			nextTile.copy(_cursor.selectedTile);
			oldTile.copy(_cursor.selectedTile);
			if (Input.map.justRelLeft) nextTile.set(_cursor.selectedTile.x - 1, _cursor.selectedTile.y);
			if (Input.map.justRelRight) nextTile.set(_cursor.selectedTile.x + 1, _cursor.selectedTile.y);
			if (Input.map.justRelUp) nextTile.set(_cursor.selectedTile.x, _cursor.selectedTile.y - 1);
			if (Input.map.justRelDown) nextTile.set(_cursor.selectedTile.x, _cursor.selectedTile.y + 1);
		}

		if (_state == "move") {
			for (p in _level.validMovePoints)
				if (p.equals(nextTile))
					_cursor.moveTo(cast nextTile.x, cast nextTile.y);

			if (Input.map.justRelZ) {
				_level.doneMoving();
				_menu.kill();
				remove(_menu, true);
				var a:Act = new Act(Act.MOVE);
				a.unit = _selectedUnit.id;
				a.loc.copy(_cursor.selectedTile);
				performAct(a);
			}
		}

		if (_state == "select") {
			_cursor.moveTo(cast nextTile.x, cast nextTile.y);
			if (Input.map.justRelZ) selectUnit(findUnitOn(cast _cursor.selectedTile.x, cast _cursor.selectedTile.y));
		}
	}

	private function findUnitOn(x:Int, y:Int):Unit {
		for (u in _unitGroup) if (u.location.x == x && u.location.y == y) return u;
		return null;
	}

	private function selectUnit(unit:Unit):Void {
		if (unit == null) return;
		_selectedUnit = unit;
		_menu = new GameMenu(unit);
		_menu.menuExit = menuExit;
		add(_menu);
	}

	private function menuExit(type:String):Void {
		_state = type;

		if (_state == "move") {
			_level.createMoveGrid(_selectedUnit);
		}

		if (_state == "item action") {
			var a:Act = _menu.act;
			trace(a.unit, a.item, a.action, a.pattern);
			performAct(a);
			_menu.kill();
			remove(_menu, true);
		}
	}

	private function performAct(a:Act):Void {
		_state = "acting";
		if (a.type == Act.MOVE) {
			var path:Path = _level.findPath(new IntPoint(a.loc.x, a.loc.y));
			var delay:Float = findUnitId(a.unit).walk(path);
			new FlxTimer().start(delay, function(t:FlxTimer):Void{_state = "select";});
		}

		if (a.type == Act.ITEM_ACTION) {
			_level.doneMoving();
			FlxG.camera.flash(0xFFFFFFFF, 1);
			new FlxTimer().start(1, function(t:FlxTimer):Void{_state = "select";});
		}
	}

	private function findUnitId(id:Int):Unit {
		for (u in _unitGroup) if (u.id == id) return u;
		return null;
	}
}
