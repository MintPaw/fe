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
				[shakeUnit.bind(2, 2, 1), 0],
			];

				for (u in act.unitTargets) {
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

	public function shakeUnit(xAmount:Int, yAmount:Int, duration:Float):Void {
	}

	public function damage(unit:Unit, amount:Int):Void {
		unit.damage(amount);
	}

	public function showDamageText(unit:Unit, amount:Int):Void {
		var t:Text = new Text();
		t.fontName = "default1";
		trace(unit.location);
		t.x = unit.location.x * Reg.TILE_SIZE;
		t.y = unit.location.y * Reg.TILE_SIZE;
		t.text = Std.string(amount);
		FlxG.state.add(t);
	}
}
