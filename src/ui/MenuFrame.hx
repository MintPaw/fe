package ui;

import flixel.*;
import flixel.math.*;
import flixel.group.*;

class MenuFrame extends FlxGroup
{
	public var select:Text->Void;
	public var hover:Text->Void;
	public var texts:Array<Text>;
	public var enabled:Bool = true;

	private var _bg:FlxSprite;
	private var _cursor:Cursor;

	private var _bgPad:FlxPoint = new FlxPoint(50, 10);
	private var _textPad:FlxPoint = new FlxPoint(10, 10);

	public function new(select:Text->Void, hover:Text->Void) {
		super();

		this.select = select;
		this.hover = hover;

		texts = [];

		var frameWidth:Int = Std.int(FlxG.width * 0.25);
		var frameHeight:Int = Std.int(FlxG.height * 0.66);

		_bg = new FlxSprite();
		_bg.x = _bgPad.x;
		_bg.y = _bgPad.y;
		_bg.scrollFactor.set();
		_bg.makeGraphic(frameWidth, frameHeight, 0xFF000000);
		add(_bg);

		_cursor = new Cursor();
		_cursor.scrollFactor.set();
		add(_cursor);
	}

	public function addItem(s:String, enabled:Bool=true):Void {
		var t:Text = new Text();
		t.scrollFactor.set();
		t.fontName = "default1";
		t.width = _bg.width - _textPad.x * 2;
		t.text = s;
		t.x = _bg.x + _textPad.x;
		t.y = _bg.y + _textPad.y + (texts.length * (t.height + 10));
		t.enabled = enabled;
		t.blit();
		add(t);

		texts.push(t);

		if (texts.length == 1) cursorTo(0);
	}

	private function cursorTo(itemNumber:Int):Void {
		_cursor.moveToText(texts[itemNumber]);
		hover(_cursor.selectedText);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		var selectedIndex:Int = texts.indexOf(_cursor.selectedText);

		if (Input.map.justRelUp && selectedIndex > 0) cursorTo(selectedIndex - 1);
		if (Input.map.justRelDown && selectedIndex < texts.length-1) cursorTo(selectedIndex + 1);
		if (Input.map.justRelZ && _cursor.selectedText.enabled) select(_cursor.selectedText);
		Input.falseAll();
	}

}
