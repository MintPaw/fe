package ;

import flixel.*;
import flixel.group.*;
import flixel.util.*;
import Item;

class CombatAnim extends FlxGroup
{
	public var act:Act;

	public function new(act:Act):Void {
		super();
		this.act = act;
		var steps:Array<Array<Dynamic>> = [];
		if (act.resolvedAction.name == "Slash") {
			steps = [
				[cameraFlash.bind(0xFFFFFFFF, 1), 2], 
				[shakeUnit.bind(2, 2, 1), 1]
			];
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
}
