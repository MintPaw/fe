package ui;

import flixel.*;
import flixel.group.*;
import flixel.group.FlxGroup;
import flixel.text.*;
import flixel.tweens.*;
import flixel.math.*;
import flixel.util.*;
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
	public var height(default, null):Float = 0;
	public var colour:FlxColor = 0xFFFFFFFF;

	public function new() {
		super();
	}

	public function set_text(s:String):String {
		text = s;
		blit();
		return s;
	}

	public function blit():Void {
		for (c in members) c.kill();
		var font:FlxBitmapFont = fonts.get(fontName);
		height = font.lineHeight;

		var lineBreaks:Array<Int> = [];

		var wordLen:Int = 0;
		var lineLen:Int = 0;
		for (i in 0...text.length) {
			var charCode:Int = text.charCodeAt(i);

			if (charCode == 32) {
				if (wordLen + lineLen > width) {
					lineBreaks.push(i);
					lineLen = 0;
				}
				wordLen += font.spaceWidth;
				lineLen += wordLen;
				wordLen = 0;
			} else {
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
				char = recycle(Char);
				char.set(FlxGraphic.fromFrame(frame), colour);
				// char = new Char(FlxGraphic.fromFrame(frame), colour);
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

	}

	public static function loadFont(name:String, imageLocation:String, dataLocation:String):Void {
		fonts.set(name, FlxBitmapFont.fromAngelCode(imageLocation, dataLocation));
	}
}