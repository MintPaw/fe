package ui;

import flixel.*;
import flixel.group.*;

class GameMenu extends FlxGroup
{
	private var _unit:Unit;
	private var _frames:Array<MenuFrame>;

	public var menuExit:String->Void;
	public var enabled:Bool = true;
	public var hidden:Bool = false;

	public function new(unit:Unit) {
		super();
		trace("enter");
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
		if (text.text.toLowerCase() == "move") {
			enabled = false;
			visible = false;
			menuExit("move");
		}
	}

	private function hover(text:Text):Void {
	}

	override public function update(elapsed:Float):Void {
		if (!enabled) return;
		super.update(elapsed);
	}

}
