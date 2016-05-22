package comps;

import Item;

class ItemC extends Comp
{
	public var itemList:Array<Item>;
	public var itemDropList:Array<Item>;

	public function new(entity:Entity) {
		super(entity);
		name = "ItemC";

		itemList = [];
		itemDropList = [];
	}

	public function getNewItem(id:Int):Void {
		for (i in Item.items) if (i.id == id) itemList.push(i.clone());
	}

}
