package ;

import flixel.*;

class Input {
	
	public static var map:Dynamic = {};

	public static function update():Void {
		map.left = map.right = map.up = map.down = map.z = map.x = map.c = false;

		map.left = FlxG.keys.justPressed.LEFT;
		map.right = FlxG.keys.justPressed.RIGHT;
		map.up = FlxG.keys.justPressed.UP;
		map.down = FlxG.keys.justPressed.DOWN;
		map.z = FlxG.keys.justPressed.Z;
		map.x = FlxG.keys.justPressed.X;
		map.c = FlxG.keys.justPressed.C;
	}
}
