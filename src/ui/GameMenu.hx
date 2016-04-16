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
		if (_unit.controllable) {
			f.addItem("Move");
			f.addItem("Other 1");
		}
		_frames.push(f);
	}

}
