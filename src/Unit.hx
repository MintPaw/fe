package;

import flixel.*;
import flixel.tile.*;
import flixel.group.*;
import flixel.math.*;
import flixel.tweens.*;
import flixel.ui.*;
import flixel.ui.FlxBar;
import flixel.util.*;
import comps.*;
import openfl.*;
import Level;

class Unit extends FlxSpriteGroup
{
	public static var UNIT_ID_COUNTER:Int = 0;

	public var mainGraphic:FlxSprite = new FlxSprite();
	public var apBar:FlxBar;

	public var items:Array<Item> = []; //
	public var drops:Array<Item> = []; //
	public var stats:Stats = {}; //
	public var ailments:Array<Ailment> = []; //
	public var name:String; //

	public var id:Int = UNIT_ID_COUNTER++; //
	public var hp:Int = 10;
	public var ap:Int = 10;
	public var location:IntPoint = new IntPoint();
	public var dead:Bool = false;
	public var attackable:Bool = true;
	public var controllable:Bool = false;
	public var state:String = "default";

	public function new() {
		super();
		apBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, Reg.TILE_SIZE, 4, this, "ap", 0, 10, true);
		apBar.createColoredFilledBar(0xFF0800FF, true, 0xFF000000);
		apBar.createColoredEmptyBar(0xFF040082, true, 0xFF000000);
		apBar.visible = false;

		mainGraphic.makeGraphic(32, 32, 0xFFFF0000);
		add(mainGraphic);
		add(apBar);
	}

	public function warp(x:Int, y:Int):Void {
		location.set(x, y);
		this.x = x * Reg.TILE_SIZE;
		this.y = y * Reg.TILE_SIZE;
	}

	public function walk(path:Path):Float {
		state = "walking";
		var moveTime:Float = 0.1;
		var delayTime:Float = 0.2;

		for (i in 0...path.path.length) {
			FlxTween.tween(this, {x:path.path[i].x * Reg.TILE_SIZE, y:path.path[i].y * Reg.TILE_SIZE}, moveTime,
					{startDelay:delayTime*i, onComplete:
						function(t:FlxTween):Void{ap -= path.costs[i]; reloadLoc();}
					});
			}

		var timeWillTake:Float = delayTime*path.path.length;
		new FlxTimer().start(timeWillTake, function(t:FlxTimer){state="default";});

		return timeWillTake;
	}

	public function getNewItem(id:Int):Void {
		for (i in Item.items) {
			if (i.id == id) {
				items.push(i.clone());
				break;
			}
		}
	}

	private function reloadLoc():Void {
		location.set(Std.int(x / Reg.TILE_SIZE), Std.int(y / Reg.TILE_SIZE));
	}

	override public function update(elapsed:Float):Void {
		if (state == "walking") {
			apBar.x = mainGraphic.x + mainGraphic.width/2 - apBar.width/2;
			apBar.y = mainGraphic.y + mainGraphic.height + apBar.height + 5;
			apBar.visible = true;
		} else {
			apBar.visible = false;
		}

		super.update(elapsed);
	}

	public function damage(amount:Int):Void {
		hp -= amount;
	}

}

typedef Stats = { 
}

typedef Ailment = { 
}
