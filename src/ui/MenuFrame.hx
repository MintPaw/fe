package ui;

import flixel.*;
import flixel.math.*;
import flixel.group.*;

class MenuFrame extends FlxGroup
{
	public var select:Text->Void;
	public var hover:Text->Void;

	private var _bg:FlxSprite;
	private var _texts:Array<Text>;
	private var _cursor:Cursor;

	private var _bgPad:FlxPoint = new FlxPoint(50, 10);
	private var _textPad:FlxPoint = new FlxPoint(10, 10);

	public function new() {
		super();

		_texts = [];

		var frameWidth:Int = Std.int(FlxG.width * 0.25);
		var frameHeight:Int = Std.int(FlxG.height * 0.66);

		_bg = new FlxSprite();
		_bg.x = _bgPad.x;
		_bg.y = _bgPad.y;
		_bg.makeGraphic(frameWidth, frameHeight, 0xFF000000);
		add(_bg);

		_cursor = new Cursor();
		add(_cursor);
	}

	public function addItem(s:String, enabled:Bool=true):Void {
		var t:Text = new Text();
		t.fontName = "default1";
		t.width = _bg.width - _textPad.x * 2;
		t.text = s;
		t.x = _bg.x + _textPad.x;
		t.y = _bg.y + _textPad.y + (_texts.length * (t.height + 10));
		t.enabled = enabled;
		t.blit();
		add(t);

		_texts.push(t);

		if (_texts.length == 1) cursorTo(0);
	}

	private function cursorTo(itemNumber:Int):Void {
		_cursor.moveToText(_texts[itemNumber]);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		var selectedIndex:Int = _texts.indexOf(_cursor.selectedText);

		if (Input.map.justUp && selectedIndex > 0) cursorTo(selectedIndex - 1);
		if (Input.map.justDown && selectedIndex < _texts.length-1) cursorTo(selectedIndex + 1);
		if (Input.map.justZ && _cursor.selectedText.enabled) select(_cursor.selectedText);
	}

}
