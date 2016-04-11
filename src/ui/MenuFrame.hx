package ui;

import flixel.*;
import flixel.group.*;

class MenuFrame extends FlxGroup
{
	private var _bg:FlxSprite;
	private var _texts:Array<Text>;

	private var _padLR:Int = 10;
	private var _padUD:Int = 10;

	public function new() {
		super();

		_texts = [];

		var frameWidth:Int = Std.int(FlxG.width * 0.25 - _padLR*2);
		var frameHeight:Int = Std.int(FlxG.height * 0.66 - _padUD*2);

		_bg = new FlxSprite();
		_bg.x = _padLR;
		_bg.y = _padUD;
		_bg.makeGraphic(frameWidth, frameHeight, 0xFF000000);
		add(_bg);
	}

	public function addItem(s:String):Void {
		var t:Text = new Text();
		t.fontName = "default1";
		t.width = _bg.width - _padLR * 2;
		t.text = s;
		t.x = _bg.x + _padLR;
		t.y = _bg.y + _padUD + (_texts.length * (t.height + 10));
		add(t);

		_texts.push(t);
	}

}
