package ui;

import flixel.*;
import flixel.group.*;

class GameMenu extends FlxGroup
{
	private var _unit:Unit;
	private var _frames:Array<MenuFrame>;

	public function new(unit:Unit) {
		super();
		_unit = unit;
		_frames = [];

		var f:MenuFrame = new MenuFrame();
		f.select = select;
		f.hover = hover;
		add(f);

		if (_unit.controllable) {
			f.addItem("Move");
			f.addItem("Other 1", false);
		}

		_frames.push(f);
	}

	private function select(text:Text):Void {
		// if (text.text.toLowerCase() == "move") 
	}

	private function hover(text:Text):Void {
	}

}
