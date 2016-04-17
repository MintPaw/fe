package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import openfl.*;

class Unit extends Entity
{
	public var ap:Int = 10;
	public var items:Array<Item>;
	public var stats:Stats;
	public var ailments:Array<Ailment>;
	public var controllable:Bool = false;

	public function new() {
		super();

		attackable = true;
	}
}

typedef Stats = { 
}

typedef Ailment = { 
}
