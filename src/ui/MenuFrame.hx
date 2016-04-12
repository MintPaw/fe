package ui;

import flixel.*;
import flixel.math.*;
import flixel.group.*;

class MenuFrame extends FlxGroup
{
	private var _bg:FlxSprite;
	private var _texts:Array<Text>;
	private var _cursor:FlxSprite;

	private var bgPad:FlxPoint = new FlxPoint(50, 10);
	private var textPad:FlxPoint = new FlxPoint(10, 10);

	public function new() {
		super();

		_texts = [];

		var frameWidth:Int = Std.int(FlxG.width * 0.25);
		var frameHeight:Int = Std.int(FlxG.height * 0.66);

		_bg = new FlxSprite();
		_bg.x = bgPad.x;
		_bg.y = bgPad.y;
		_bg.makeGraphic(frameWidth, frameHeight, 0xFF000000);
		add(_bg);

		_cursor = new FlxSprite("assets/img/cursor.png");
		add(_cursor);

	}

	public function addItem(s:String):Void {
		var t:Text = new Text();
		t.fontName = "default1";
		t.width = _bg.width - textPad.x * 2;
		t.text = s;
		t.x = _bg.x + textPad.x;
		t.y = _bg.y + textPad.y + (_texts.length * (t.height + 10));
		t.blit();
		add(t);

		_texts.push(t);

		if (_texts.length == 1) cursorTo(0);
	}

	private function cursorTo(itemNumber:Int):Void {
		var item:Text = _texts[itemNumber];
		_cursor.x = item.x - _cursor.width + Cursor.align.x;
		_cursor.y = item.y + item.height/2 - _cursor.height/2 + Cursor.align.y;
	}

}
