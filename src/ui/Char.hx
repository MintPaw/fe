package ui;

import flixel.*;
import flixel.group.*;
import flixel.text.*;
import flixel.util.*;
import flixel.tweens.*;
import flixel.system.FlxAssets;
import openfl.geom.*;

class Char extends FlxSprite
{
	public var args:Map<String, Float> = new Map();

	public function new() {
		args.set("colour", 0xFFFFFF);
		super();
	}

	public function set(glyph:FlxGraphicAsset, argsIn:Map<String, Float>):Void {
		for (k in argsIn.keys()) args.set(k, argsIn.get(k));
		if (args.exists("fadeOut")) args.set("dieIn", args.get("fadeOut"));

		x = 0;
		y = 0;
		alpha = 1;
		angle = 0;

		loadGraphic(glyph);
		var trans:ColorTransform = new ColorTransform();
		trans.color = Std.int(args.get("colour"));
		pixels.colorTransform(pixels.rect, trans);
	}

	public function start():Void {
		for (k in args.keys()) {
			var v:Float = args.get(k);
			if (k == "fadeOut") FlxTween.tween(this, { alpha: 0 }, v);
			if (k == "fallTime") FlxTween.tween(this, { y: y + args.get("fallDist") }, v);
			if (k == "dieIn") new FlxTimer().start(v, function(t:FlxTimer){kill();});
		}
	}
}
