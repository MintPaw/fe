package ;

import flixel.math.*;
import Item;

class Act
{
	public static var NONE:Int = 0;
	public static var MOVE:Int = 1;
	public static var ITEM_ACTION:Int = 2;

	public var type:Int = 0;

	public var unitId:Int;
	public var itemId:Int = -1;
	public var actionId:Int = -1;
	public var patternId:Int = -1;

	public var unit:Unit;
	public var item:Item;
	public var action:Action;
	public var pattern:Pattern;
	public var unitTargets:Array<Unit> = [];

	public var loc:IntPoint = new IntPoint();

	public function new(type:Int) {
		this.type = type;
	}
	
	public function resolve(units:Array<Unit>):Void {
		for (u in units) if (u.id == unitId) unit = u;

		if (itemId != -1) item = unit.items[itemId];
		if (actionId != -1) action = item.actions[actionId];

		if (patternId != -1) {
			pattern = action.patterns[patternId];

			for (u in units)
				for (tile in pattern.grid)
					if (u.location.x == unit.location.x + tile.x && u.location.y == unit.location.y + tile.y)
						unitTargets.push(u);

		}
	}
}
