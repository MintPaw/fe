package ;

import flixel.math.*;

class Act
{
	public static var NONE:Int = 0;
	public static var MOVE:Int = 1;
	public static var ITEM_ACTION:Int = 2;

	public var type:Int = 0;

	public var unit:Int;
	public var item:Int;
	public var action:Int;
	public var pattern:Int;

	public var loc:FlxPoint = new FlxPoint();

	public function new(type:Int) {
		this.type = type;
	}
}
