package ui;

import flixel.*;
import flixel.group.*;
import flixel.group.FlxGroup;
import flixel.text.*;
import flixel.tweens.*;
import flixel.math.*;
import flixel.graphics.*;
import flixel.graphics.frames.*;

class Text extends FlxTypedGroup<Char>
{
	public static var fonts:Map<String, FlxBitmapFont> = new Map();
	
	public var fontName:String;
	public var text(default, set):String;
	public var x:Float = 0;
	public var y:Float = 0;

	public function new() {
		super();
	}

	public function set_text(s:String):String {
		text = s;
		var curPos:FlxPoint = FlxPoint.get(x, y);

		for (i in 0...text.length) {
			var charCode:Int = text.charCodeAt(i);
			var frame:FlxFrame = fonts.get(fontName).getCharFrame(charCode);
			var char:Char = new Char(FlxGraphic.fromFrame(frame));

			char.x = curPos.x;
			char.y = curPos.y;

			curPos.x += fonts.get(fontName).getCharAdvance(charCode);

			add(char);
		}

		curPos.put();

		return s;
	}

	public static function loadFont(name:String, imageLocation:String, dataLocation:String):Void {
		fonts.set(name, FlxBitmapFont.fromAngelCode(imageLocation, dataLocation));
	}
}
