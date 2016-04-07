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

		stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
	}

	private function kUp(e:KeyboardEvent):Void {
#if !flash
		if (e.keyCode == Keyboard.ESCAPE) Sys.exit(1);
#end
	}
}
