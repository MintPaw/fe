package;

import flixel.math.*;

class Item
{
	public var id:Int;
	public var wear:Int;
	public var age:Int;
	public var exp:Int;
	public var expTillNext:Int;
	public var nextId:Int;
	public var actions:Array<Action>;

	public function new() {
	}

	public function use(action:Action):Void {
	}

	public function clone():Item {
		//todo: no
		return this;
	}
}

typedef Action = {
	name:String,
	description:String,
	pattern:Array<Pattern>,
	damage:Int,
	accuracy:Int,
	splash:Bool
}

typedef Pattern = {
	name:String,
	grid:Array<FlxPoint>
}

