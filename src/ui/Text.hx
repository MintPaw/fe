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

	public var scrollFactor:FlxPoint = new FlxPoint(1, 1);
	
	public var fontName:String;
	public var x:Float = 0;
	public var y:Float = 0;
	public var width:Float = 1000;
	public var height(default, null):Float = 0;
	public var colour:FlxColor = 0xFFFFFFFF;
	public var enabled:Bool = true;

	private var _text:String = "";

	public static function loadFont(name:String, imageLocation:String, dataLocation:String):Void {
		fonts.set(name, FlxBitmapFont.fromAngelCode(imageLocation, dataLocation));
	}

	public function new() {
		super();

		for (fName in fonts.keys()) {
			fontName = fName;
			break;
		}
	}

	public function blit():Void {
		if (_text == null) {
			trace("No text");
			return;
		}
		if (fonts.get(fontName) == null) {
			trace("No font called " + fontName);
			return;
		}

		for (c in members) c.kill();
		var font:FlxBitmapFont = fonts.get(fontName);
		height = font.lineHeight;

		var lineBreaks:Array<Int> = [];

		var wordLen:Int = 0;
		var lineLen:Int = 0;
		for (i in 0..._text.length) {
			var charCode:Int = _text.charCodeAt(i);

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

		for (i in 0..._text.length) {
			if (lineBreaks.indexOf(i) != -1) {
				curPos.x = x;
				curPos.y += font.lineHeight;
			}
			var charCode:Int = _text.charCodeAt(i);

			if (charCode == 32) {
				curPos.x += font.spaceWidth;
				continue;
			}

			var frame:FlxFrame = font.getCharFrame(charCode);
			var char:Char;
			try {
				char = recycle(Char);
				char.scrollFactor.copyFrom(scrollFactor);
				char.set(FlxGraphic.fromFrame(frame), colour);
			} catch(e:Dynamic) {
				trace("Error on charCode " + charCode + "(" + _text.charAt(i) + ")");
				throw e;
			}

			char.x = curPos.x;
			char.y = curPos.y;
			char.alpha = enabled ? 1 : 0.5;

			curPos.x += font.getCharAdvance(charCode);

			add(char);
		}

		curPos.put();
	}

	public function setText(s:String=""):String {
		_text = "";
		return addText(s);
	}

	public function addText(s:String):String {
		_text += s;
		blit();
		return s;
	}
	
	public function getText():String {
		return _text;
	}

//todonow fade away text
}
