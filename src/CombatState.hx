package;

import flixel.*;
import flixel.tile.*;
import flixel.math.*;
import openfl.*;

class CombatState extends FlxState
{
	private var _map:Level;

	public function new() {
		super();
	}

	override public function create():Void {
		_map = new Level("assets/map/test.tmx", "assets/img/tilemap.png");
		add(_map.tilemap);
	}
}
