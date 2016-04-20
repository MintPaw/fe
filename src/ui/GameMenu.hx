package ui;

import flixel.*;
import flixel.group.*;
import Item;

class GameMenu extends FlxGroup
{
	private var _unit:Unit;
	private var _itemId:Int;
	private var _actionId:Int;
	private var _frames:Array<MenuFrame>;

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
					var f:MenuFrame = new MenuFrame(select, hover);
					for (a in item.actions) f.addItem(a.name);
					add(f);

					_frames[_frames.length-1].kill();
					_frames.push(f);
					_itemId = item.id;
					state = "item";
					return;
				}
			}
		}

		if (state == "item") {
			for (action in _unit.items[_itemId].actions) {
				if (text.text == action.name) {
					var f:MenuFrame = new MenuFrame(select, hover);
					for (p in action.patterns) f.addItem(p.name);
					add(f);

					_frames[_frames.length-1].kill();
					_frames.push(f);
					_actionId = _unit.items[_itemId].actions.indexOf(action);
					state = "action";
					return;
				}
			}
		}

		if (state == "action") {
			for (pattern in _unit.items[_itemId].actions[_actionId].patterns) {
				if (text.text == pattern.name) {
					act = new Act(Act.ITEM_ACTION);
					act.unit = _unit.id;
					act.item = _itemId;
					act.action = _actionId;
					act.pattern = _unit.items[_itemId].actions[_actionId].patterns.indexOf(pattern);
					menuExit("item action");
				}
			}
		}
	}

	private function hover(text:Text):Void {
	}

	override public function update(elapsed:Float):Void {
		if (!enabled) return;
		super.update(elapsed);
	}

}
