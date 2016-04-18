package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import openfl.*;

class Entity extends FlxSpriteGroup
{
	public static var ID_COUNTER:Int = 0;

	public var id:Int = ID_COUNTER++;
	public var hp:Int = 100;
	public var location:FlxPoint = new FlxPoint();
	public var attackable:Bool = false;
	public var dead:Bool = false;
	public var drops:Array<Item> = [];
	
	public var mainGraphic:FlxSprite = new FlxSprite();

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
