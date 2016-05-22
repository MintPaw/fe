package comps;

import flixel.tweens.*;
import flixel.util.*;
import Level;

class MoveC extends Comp
{
	public var location:IntPoint;

	public function new(entity:Entity) {
		super(entity);
		name = "MoveC";

		location = new IntPoint();
	}

	public function warpToTile(x:Int, y:Int, updateVisualLoc:Bool=true):Void {
		location.set(x, y);
		if (updateVisualLoc) updateVisual();
	}

	public function walk(path:Path):Float {
		// state = "walking";
		var render:RenderC = cast entity.getComp("RenderC");
		var stat:StatC = cast entity.getComp("StatC");
		var moveTime:Float = 0.1;
		var delayTime:Float = 0.2;

		for (i in 0...path.path.length) {
			FlxTween.tween(render.whole, {x:path.path[i].x * Reg.TILE_SIZE, y:path.path[i].y * Reg.TILE_SIZE}, moveTime,
					{startDelay:delayTime*i, onComplete:
						function(t:FlxTween):Void{stat.ap -= path.costs[i]; reloadLoc();}
					});
		}

		var timeWillTake:Float = delayTime*path.path.length;
		// new FlxTimer().start(timeWillTake, function(t:FlxTimer){state="default";});

		return timeWillTake;
	}

	public function updateVisual():Void {
		entity.x = entity.x * Reg.TILE_SIZE;
		entity.y = entity.y * Reg.TILE_SIZE;
	}

	private function reloadLoc():Void {
		location.set(Std.int(entity.x / Reg.TILE_SIZE), Std.int(entity.y / Reg.TILE_SIZE));
	}
}
