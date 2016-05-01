package ;

import flixel.math.*;
import Item;

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

	public var resolvedUnit:Unit;
	public var resolvedItem:Item;
	public var resolvedAction:Action;
	public var resolvedPattern:Pattern;

	public var loc:IntPoint = new IntPoint();

	public function new(type:Int) {
		this.type = type;
	}
	
	public function resolve(u:Unit):Void {
		resolvedUnit = u;
		resolvedItem = u.items[item];
		resolvedAction = resolvedItem.actions[action];
		resolvedPattern = resolvedAction.patterns[pattern];
	}
}
