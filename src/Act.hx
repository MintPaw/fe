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
	public var item:Int = -1;
	public var action:Int = -1;
	public var pattern:Int = -1;

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
		if (item != -1) resolvedItem = u.items[item];
		if (action != -1) resolvedAction = resolvedItem.actions[action];
		if (pattern != -1) resolvedPattern = resolvedAction.patterns[pattern];
	}
}
