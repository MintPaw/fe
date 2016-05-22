package;

import comps.*;
import flixel.group.*;

class Entity extends FlxSpriteGroup {
	public static var ENTITY_ID_COUNTER:Int = 0;

	public var id:Int;
	public var name:String;
	public var comps:Array<Comp>;

	public function new() {
		super();
		id = ENTITY_ID_COUNTER++;
		comps = [];
	}

	public function getComp(name:String):Comp {
		for (comp in comps) if (comp.name == name) return comp;
		return null;
	}
}
