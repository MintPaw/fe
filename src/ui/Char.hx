package ui;

import flixel.*;
import flixel.group.*;
import flixel.text.*;
import flixel.util.*;
import flixel.system.FlxAssets;
import openfl.geom.*;

class Char extends FlxSprite
{
	public function new() {
		super();
	}

	public function set(glyph:FlxGraphicAsset, colour:FlxColor):Void {
		loadGraphic(glyph);
		var trans:ColorTransform = new ColorTransform();
		trans.color = colour;
		pixels.colorTransform(pixels.rect, trans);
	}
}
