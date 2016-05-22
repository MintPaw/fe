package comps;

import flixel.group.*;
import flixel.*;

class RenderC extends Comp
{
	public var whole:FlxSpriteGroup;
	public var main:FlxSprite;

	public function new(entity:Entity) {
		super(entity);
		name = "RenderC";

		whole = new FlxSpriteGroup();

		main = new FlxSprite();
		main.makeGraphic(32, 32, 0xFFFF0000);
		whole.add(main);
	}

}
