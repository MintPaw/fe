package ;

import flixel.*;
import flixel.group.*;
import flixel.util.*;
import ui.*;
import Item;

class CombatAnim extends FlxGroup
{
	public var act:Act;

	public function new(act:Act):Void {
		super();
		this.act = act;
		var steps:Array<Array<Dynamic>> = [];
		if (act.action.name == "Slash") {
			steps = [
				[cameraFlash.bind(0xFFFFFFFF, 1), 2], 
				[shakeEntity.bind(2, 2, 1), 0],
			];

				for (u in act.entityTargets) {
					steps.push([damage.bind(u, act.action.damage), 0]);
					steps.push([showDamageText.bind(u, act.action.damage), 0]);
				}
		}

		var totalTime:Float = 0;
		for (step in steps) {
			new FlxTimer().start(totalTime, function(t:FlxTimer){step[0]();});
			totalTime += step[1];
		}
	}

	public function cameraFlash(color:Int, duration:Float):Void {
		FlxG.camera.flash(color, duration, null, true);
	}

	public function shakeEntity(xAmount:Int, yAmount:Int, duration:Float):Void {
	}

	public function damage(entity:Entity, amount:Int):Void {
		entity.getComp("StatC").damage(amount);
	}

	public function showDamageText(entity:Entity, amount:Int):Void {
		var t:Text = new Text();
		t.fontName = "default1";
		t.x = entity.getComp("MoveC").location.x * Reg.TILE_SIZE;
		t.y = entity.getComp("MoveC").location.y * Reg.TILE_SIZE;
		t.addArg("fadeOut", 1);
		t.addArg("fallDist", 50);
		t.addArg("fallTime", 1);
		t.addText(Std.string(amount));
		FlxG.state.add(t);
	}
}
