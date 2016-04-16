package ;

import flixel.*;

class Input {
	
	public static var map:Dynamic = {};

	public static function update():Void {
		falseAll();

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

		map.justRelLeft = FlxG.keys.justReleased.LEFT;
		map.justRelRight = FlxG.keys.justReleased.RIGHT;
		map.justRelUp = FlxG.keys.justReleased.UP;
		map.justRelDown = FlxG.keys.justReleased.DOWN;
		map.justRelZ = FlxG.keys.justReleased.Z;
		map.justRelX = FlxG.keys.justReleased.X;
		map.justRelC = FlxG.keys.justReleased.C;
	}

	public static function falseAll():Void {
		map.left = map.right = map.up = map.down = map.z = map.x = map.c = false;
		map.justLeft = map.justRight = map.justUp = map.justDown = map.justZ = map.justX = map.justC = false;
		map.justRelLeft = map.justRelRight = map.justRelUp = map.justRelDown = map.justRelZ = map.justRelX = map.justRelC = false;
	}
}
