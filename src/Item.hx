package;

import flixel.math.*;
import yaml.*;
import yaml.util.ObjectMap;
import openfl.*;

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

	public function new() {
	}

	public function use(action:Action):Void {
	}

	public function clone():Item {
		return Reflect.copy(this);
	}

	public static function init():Void {
		var data:AnyObjectMap = Yaml.parse(Assets.getText("assets/info/items.yaml"));
		var itemsList:Array<Dynamic> = data.get("items");

		for (itemStruct in itemsList) {
			var item:Item = new Item();
			item.name = itemStruct.get("name");
			item.id = itemStruct.get("id");
			item.description = itemStruct.get("description");
			item.expTillNext = itemStruct.get("expTillNext");
			item.nextId = itemStruct.get("nextId");
			item.actions = [];
			for (actionStruct in cast(itemStruct.get("actions"), Array<Dynamic>)) {
				var action:Action = {};
				action.name = actionStruct.get("name");
				action.description = actionStruct.get("description");
				action.damage = actionStruct.get("damage");
				
				action.patterns = [];
				for (patternStruct in cast(actionStruct.get("patterns"), Array<Dynamic>)) {
					var p:Pattern = {};
					p.name = patternStruct.get("name");
					p.grid = [];
					for (tileStruct in cast(patternStruct.get("grid"), Array<Dynamic>)) {
						var tile:IntPoint = new IntPoint(tileStruct[0], tileStruct[1]);
						p.grid.push(tile);
					}
					action.patterns.push(p);
				}
				item.actions.push(action);
			}
			items.push(item);
		}
	}
}

typedef Action = {
	?name:String,
	?description:String,
	?patterns:Array<Pattern>,
	?damage:Int,

	?accuracy:Int,
	?splash:Bool
}

typedef Pattern = {
	?name:String,
	?grid:Array<IntPoint>
}
