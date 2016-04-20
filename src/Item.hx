package;

import flixel.math.*;

typedef Action = {
	name:String,
	description:String,
	patterns:Array<Pattern>,
	damage:Int,

	?accuracy:Int,
	?splash:Bool
}

typedef Pattern = {
	name:String,
	grid:Array<FlxPoint>
}

class Item
{
	public static var items:Array<Item> = [];

	public var name:String;
	public var description:String;
	public var id:Int;
	public var wear:Int;
	public var age:Int;
	public var exp:Int;
	public var expTillNext:Int;
	public var nextId:Int;
	public var actions:Array<Action>;

	public function new(name:String, description:String, id:Int, expTillNext:Int, nextId:Int, actions:Array<Action>) {
		this.id = id;
		this.expTillNext = expTillNext;
		this.nextId = nextId;
		this.actions = actions.copy();
		this.name = name;
		this.description = description;
	}

	public function use(action:Action):Void {
	}

	public function clone():Item {
		return new Item(name, description, id, expTillNext, nextId, actions);
	}

	public static function init():Void {
		items.push(new Item(
					"Sword",
					"A sword.",
					0, 100, 1, [
					{
						name:"Slash",
						description:"Attack a wide area in front of you", 
						damage:3,
						patterns: [
						{
							name:"Up",
							grid:[
								new FlxPoint(0, -1)
							]
						},{
							name:"Down",
							grid:[
								new FlxPoint(0, 1)
							]
						},{
							name:"Left",
							grid:[
								new FlxPoint(-1, 0)
							]
						},{
							name:"Right",
							grid:[
								new FlxPoint(1, 0)
							]
						}
						]
					}
					]));
	}
}

