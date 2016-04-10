package ui;

import flixel.*;
import flixel.group.*;

class GameMenu extends FlxSubState
{
	private var _unit:Unit;
	private var _frames:Array<MenuFrame>;

	public function new(unit:Unit) {
		super();

		_unit = unit;
		_frames = [];
	}

	override public function create():Void {
		var f:MenuFrame = new MenuFrame();
		add(f);
		_frames.push(f);
	}
}
