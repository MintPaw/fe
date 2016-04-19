package;

import openfl.display.*;
import openfl.events.*;
import openfl.ui.*;
import flixel.*;

class Main extends Sprite
{
	
	public function new() {
		super();

		var f:FlxGame = new FlxGame(stage.stageWidth, stage.stageHeight, MainState, 1, 60, 60, true, false);
		addChild(f);

		new mintDebugger.MintDebugger(stage, f);
		mintDebugger.MintDebugger.priorityNames = ["_state", "members", "_cursor"];

		stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
		stage.addEventListener(Event.ENTER_FRAME, update);
	}

	private function update(e:Event):Void {
		Input.update();
	}

	private function kUp(e:KeyboardEvent):Void {
#if (!flash && !html5)
		if (e.keyCode == Keyboard.ESCAPE) Sys.exit(1);
#end
	}
}
