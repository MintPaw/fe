package;

import flixel.*;
import flixel.tile.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import openfl.*;

class CombatState extends FlxState
{
	private var _level:Level;
	private var _unitGroup:FlxTypedGroup<Unit>;
	private var _cursor:Cursor;

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
		add(_cursor);
	}
}
