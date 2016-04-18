package ;

import flixel.math.*;

class Action
{
	public static var MOVE:Int = 0;

	public var type:Int;
	public var source:Int;
	public var dest:Int;
	public var loc:FlxPoint;

	public function new(type:Int) {
		this.type = type;
	}
}
