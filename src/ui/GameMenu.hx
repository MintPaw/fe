package ui;

import flixel.*;
import flixel.group.*;
import Item;

class GameMenu extends FlxGroup
{
	private var _unit:Unit;
	private var _item:Item;
	private var _action:Action;
	private var _frames:Array<MenuFrame>;
	private var _currentFrame:MenuFrame;

	public var state:String = "main";
	public var menuExit:String->Void;
	public var enabled:Bool = true;
	public var hidden:Bool = false;
	public var act:Act;

	public function new(unit:Unit) {
		super();
		_unit = unit;
		_frames = [];

		var f:MenuFrame = new MenuFrame(select, hover);
		_currentFrame = f;
		add(f);

		if (_unit.controllable) {
			f.addItem("Move");
			for (item in _unit.items) f.addItem(item.name);
		}

		_frames.push(f);
	}

	private function select(text:Text):Void {
		if (state == "main") {
			if (text.text.toLowerCase() == "move") {
				enabled = visible = false;
				menuExit("move");
			}

			for (item in _unit.items) {
				if (text.text == item.name) {
					_item = item;
					state = "item";

					var f:MenuFrame = new MenuFrame(select, hover);
					_currentFrame = f;
					for (a in item.actions) f.addItem(a.name);
					add(f);
					_frames[_frames.length-1].kill();
					_frames.push(f);
					return;
				}
			}
		}

		if (state == "item") {
			for (action in _item.actions) {
				if (text.text == action.name) {
					_action = action;
					state = "action";

					var f:MenuFrame = new MenuFrame(select, hover);
					_currentFrame = f;
					for (p in action.patterns) f.addItem(p.name);
					add(f);
					_frames[_frames.length-1].kill();
					_frames.push(f);
					return;
				}
			}
		}

		if (state == "action") {
			for (pattern in _action.patterns) {
				if (text.text == pattern.name) {
					act = new Act(Act.ITEM_ACTION);
					act.unit = _unit.id;
					act.item = _unit.items.indexOf(_item);
					act.action = _item.actions.indexOf(_action);
					act.pattern = _action.patterns.indexOf(pattern);
					menuExit("item action");
				}
			}
		}
	}

	private function hover(text:Text):Void {
		if (state == "item") {
			Reg.level.showPattern(_unit, _item.actions[_currentFrame.texts.indexOf(text)]);
		} else if (state == "action") {
			Reg.level.showPattern(_unit, _action, _currentFrame.texts.indexOf(text));
		}
	}

	override public function update(elapsed:Float):Void {
		if (!enabled) return;
		super.update(elapsed);
	}

}
