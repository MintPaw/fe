package ;

import flixel.math.*;
import Item;

class Act
{
	public static var NONE:Int = 0;
	public static var MOVE:Int = 1;
	public static var ITEM_ACTION:Int = 2;

	public var type:Int = 0;

	public var entityId:Int;
	public var itemId:Int = -1;
	public var actionId:Int = -1;
	public var patternId:Int = -1;

	public var entity:Entity;
	public var item:Item;
	public var action:Action;
	public var pattern:Pattern;
	public var entityTargets:Array<Entity> = [];

	public var loc:IntPoint = new IntPoint();

	public function new(type:Int) {
		this.type = type;
	}
	
	public function resolve(entities:Array<Entity>):Void {
		for (curEnt in entities) if (curEnt.id == entityId) entity = curEnt;

		if (itemId != -1) item = entity.getComp("ItemC").itemList[itemId];
		if (actionId != -1) action = item.actions[actionId];

		if (patternId != -1) {
			pattern = action.patterns[patternId];

			for (curEnt in entities)
				for (tile in pattern.grid)
					if (curEnt.getComp("MoveC").location.x == entity.getComp("MoveC").location.x + tile.x &&
							curEnt.getComp("MoveC").location.y == entity.getComp("MoveC").location.y + tile.y)
						entityTargets.push(curEnt);

		}
	}
}
