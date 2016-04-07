package;

import flixel.*;
import flixel.FlxCamera;
import flixel.tile.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import openfl.*;

class CombatState extends FlxState
{
	private static var SELECT:Int = 0;
	private static var MENU:Int = 1;

	private var _level:Level;
	private var _cursor:Cursor;

	private var _unitGroup:FlxTypedGroup<Unit>;
	private var _selectedUnit:Unit = null;

	private var _state:Int;

	public function new() {
		super();
	}

	override public function create():Void {
		_level = new Level("assets/map/test.tmx", "assets/img/tilemap.png");
		add(_level.tilemap);
		
		_unitGroup = new FlxTypedGroup<Unit>();

		var p = new Unit();
		p.warp(cast _level.playerSpawn.x, cast _level.playerSpawn.y);
		_unitGroup.add(p);
		add(p);

		_cursor = new Cursor();
		_cursor.moveTo(cast p.location.x, cast p.location.y);
		add(_cursor);

		_state = SELECT;
		FlxG.camera.setScrollBoundsRect(0, 0, _level.tilemap.width, _level.tilemap.height, true);
		FlxG.camera.follow(_cursor, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.antialiasing = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		var left, right, up, down, a, b, c;
		left = right = up = down = a = b = c = false;

		if (FlxG.keys.justPressed.LEFT) left = true;
		if (FlxG.keys.justPressed.RIGHT) right = true;
		if (FlxG.keys.justPressed.UP) up = true;
		if (FlxG.keys.justPressed.DOWN) down = true;
		if (FlxG.keys.justPressed.Z) a = true;
		if (FlxG.keys.justPressed.X) b = true;
		if (FlxG.keys.justPressed.Y) c = true;

		if (_state == SELECT) {
			if (left) _cursor.moveTo(cast _cursor.location.x - 1, cast _cursor.location.y);
			if (right) _cursor.moveTo(cast _cursor.location.x + 1, cast _cursor.location.y);
			if (up) _cursor.moveTo(cast _cursor.location.x, cast _cursor.location.y - 1);
			if (down) _cursor.moveTo(cast _cursor.location.x, cast _cursor.location.y + 1);

			if (a) {
				var u:Unit = findUnitOn(cast _cursor.location.x, cast _cursor.location.y);
				if (u != null) selectUnit(u);
			}

		}
	}

	private function findUnitOn(x:Int, y:Int):Unit {
		for (u in _unitGroup) if (u.location.x == x && u.location.y == y) return u;
		return null;
	}

	private function selectUnit(unit:Unit):Void {
		_selectedUnit = unit;
	}
}
