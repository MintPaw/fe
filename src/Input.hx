package ;

import flixel.*;

class Input {
	
	public static var map:Dynamic = {};

	public static function update():Void {
		map.left = map.right = map.up = map.down = map.z = map.x = map.c = false;
		map.justLeft = map.justRight = map.justUp = map.justDown = map.justZ = map.justX = map.justC = false;

		map.left = FlxG.keys.pressed.LEFT;
		map.right = FlxG.keys.pressed.RIGHT;
		map.up = FlxG.keys.pressed.UP;
		map.down = FlxG.keys.pressed.DOWN;
		map.z = FlxG.keys.pressed.Z;
		map.x = FlxG.keys.pressed.X;
		map.c = FlxG.keys.pressed.C;

		map.justLeft = FlxG.keys.justPressed.LEFT;
		map.justRight = FlxG.keys.justPressed.RIGHT;
		map.justUp = FlxG.keys.justPressed.UP;
		map.justDown = FlxG.keys.justPressed.DOWN;
		map.justZ = FlxG.keys.justPressed.Z;
		map.justX = FlxG.keys.justPressed.X;
		map.justC = FlxG.keys.justPressed.C;
	}
}
