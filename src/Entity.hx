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

	public function addComp(compClassName:String) {
		comps.push(Type.createInstance(Type.resolveClass(compClassName), [this]));
	}

	public function testComp(name:String):Bool {
		for (comp in comps) if (comp.name == name) return true;
		return false;
	}

	// @:generic public function getCompAs<T>(name:String, classAs:T):T {
	// 	for (comp in comps) if (comp.name == name) return comp;
	// 	throw 'No comp $name';
	// 	return null;
	// }

	public function getComp(name:String):Dynamic {
		for (comp in comps) if (comp.name == name) return comp;
		throw 'No comp $name';
		return null;
	}
}
