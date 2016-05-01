package ;

import flixel.*;
import flixel.group.*;
import Item;

class CombatAnim extends FlxGroup
{
	public static var NONE:Int = 0;
	public static var FLASH1:Int = 1;

	public var action:Act;

	public function new(a:Act):Void {
		super();
		action = a;
		if (a.resolvedAction.name == "Slash") {
			//todonow preform
		}
	}
}
