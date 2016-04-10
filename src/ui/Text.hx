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
	public var width:Float = 1000;

	public function new() {
		super();
	}

	public function set_text(s:String):String {
		text = s;
		var font:FlxBitmapFont = fonts.get(fontName);

		var lineBreaks:Array<Int> = [];

		var curWord:String = "";
		var wordLen:Int = 0;
		var curLine:String = "";
		var lineLen:Int = 0;
		for (i in 0...text.length) {
			var charCode:Int = text.charCodeAt(i);

			if (charCode == 32) {
				wordLen += font.spaceWidth;
				if (wordLen + lineLen > width) {
					lineBreaks.push(i);
					lineLen = 0;
					curLine = "";
				}
				curLine += curWord;
				lineLen += wordLen;
				wordLen = 0;
			} else {
				curWord += text.charAt(i);
				wordLen += font.getCharAdvance(charCode);
			}
		}

		var curPos:FlxPoint = FlxPoint.get(x, y);

		for (i in 0...text.length) {
			if (lineBreaks.indexOf(i) != -1) {
				curPos.x = x;
				curPos.y += font.lineHeight;
			}
			var charCode:Int = text.charCodeAt(i);

			if (charCode == 32) {
				curPos.x += font.spaceWidth;
				continue;
			}

			var frame:FlxFrame = font.getCharFrame(charCode);
			var char:Char;
			try {
				char = new Char(FlxGraphic.fromFrame(frame));
			} catch(e:Dynamic) {
				trace("Error on charCode " + charCode + "(" + text.charAt(i) + ")");
				throw e;
			}

			char.x = curPos.x;
			char.y = curPos.y;

			curPos.x += font.getCharAdvance(charCode);

			add(char);
		}

		curPos.put();

		return s;
	}

	public static function loadFont(name:String, imageLocation:String, dataLocation:String):Void {
		fonts.set(name, FlxBitmapFont.fromAngelCode(imageLocation, dataLocation));
	}
}
