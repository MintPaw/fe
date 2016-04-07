package;

import flixel.*;
import flixel.tile.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import openfl.*;

class CombatState extends FlxState
{
	private var _level:Level;
	private var _unitGroup:FlxTypedGroup<Unit> = new FlxTypedGroup<Unit>();

	public function new() {
		super();
	}

	override public function create():Void {
		_level = new Level("assets/map/test.tmx", "assets/img/tilemap.png");
		add(_level.tilemap);
		
		var p = new Unit();
		p.warp(cast _level.playerSpawn.x, cast _level.playerSpawn.y);
		_unitGroup.add(p);
		add(p);
	}
}
