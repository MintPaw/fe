package;

import flixel.*;
import ui.*;

class MainState extends FlxState
{
	
	public function new() {
		super();
	}

	override public function create():Void {
		Text.loadFont("default0", "assets/font/default0.png", "assets/font/default0.fnt");
		Text.loadFont("default1", "assets/font/default1.png", "assets/font/default1.fnt");
		Text.loadFont("default2", "assets/font/default2.png", "assets/font/default2.fnt");
		Text.loadFont("default3", "assets/font/default3.png", "assets/font/default3.fnt");

		FlxG.switchState(new CombatState());
	}
}
