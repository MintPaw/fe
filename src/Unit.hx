package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import openfl.*;

class Unit extends FlxSpriteGroup
{
	public static var UNIT_ID_COUNTER:Int = 0;

	public var mainGraphic:FlxSprite = new FlxSprite();

	public var items:Array<Item> = [];
	public var drops:Array<Item> = [];
	public var stats:Stats = {};
	public var ailments:Array<Ailment> = [];

	public var id:Int = UNIT_ID_COUNTER++;
	public var hp:Int = 100;
	public var ap:Int = 10;
	public var location:FlxPoint = new FlxPoint();
	public var dead:Bool = false;
	public var attackable:Bool = true;
	public var controllable:Bool = false;

	public function new() {
		super();

		mainGraphic.makeGraphic(32, 32, 0xFFFF0000);
		add(mainGraphic);
	}

	public function warp(x:Int, y:Int):Void {
		location.set(x, y);
		this.x = x * Reg.TILE_SIZE;
		this.y = y * Reg.TILE_SIZE;
	}
}

typedef Stats = { 
}

typedef Ailment = { 
}
