package ;

import flixel.math.*;

class Action
{
	public static var NONE:Int = 0;
	public static var MOVE:Int = 1;

	public var type:Int = 0;
	public var source:Int;
	public var dest:Int;
	public var loc:FlxPoint = new FlxPoint();

	public function new(type:Int) {
		this.type = type;
	}
}
