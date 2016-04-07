package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import openfl.*;

class Entity extends FlxSpriteGroup
{
	public var hp:Int = 100;
	public var location:FlxPoint = new FlxPoint();
	public var attackable:Bool = false;
	public var dead:Bool = false;
	public var drops:Array<Item> = [];

	public function new() {
		super();

		makeGraphic(32, 32, 0xFFFF0000);
	}
}
