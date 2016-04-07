//Unit => ap:Int, items:Array<Item>, move(loc:Array<Point>):Void, ailments:Array<Ailment>, stats:Stats

package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import openfl.*;

class Unit extends Entity
{
	public var ap:Int;
	public var items:Array<Item>;
	public var stats:Stats;
	public var ailments:Array<Ailment>;

	public function new() {
		super();

		makeGraphic(32, 32, 0xFFFF0000);
	}
}

typedef Stats = { 
}

typedef Ailments = { 
}
