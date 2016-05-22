package;

import ui.*;
import flixel.*;
import flixel.FlxCamera;
import flixel.tile.*;
import flixel.group.FlxGroup;
import flixel.math.*;
import flixel.util.*;
import flixel.tweens.*;
import openfl.*;
import Level;
import comps.*;

class CombatState extends FlxState
{
	private var _level:Level;
	private var _cursor:Cursor;
	private var _menu:GameMenu;

	private var _entityGroup:FlxTypedGroup<Entity>;
	private var _selectedEntity:Entity = null;

	private var _state:String;

	public function new() {
		super();
	}

	override public function create():Void {
		_level = new Level("assets/map/test.tmx", "assets/img/tilemap.png");
		Reg.mapWidth = _level.tilemap.widthInTiles;
		Reg.mapHeight = _level.tilemap.heightInTiles;
		Reg.level = _level;
		add(_level.tilemap);
		add(_level.moveGrid);

		_entityGroup = new FlxTypedGroup<Entity>();

		for (entity in _level.entities) {
			if (entity.name == "player") entity.getComp("ItemC").getNewItem(0);
			_entityGroup.add(cast add(entity));
		}

		_cursor = new Cursor();
		for (entity in _entityGroup) {
			var control:ControlC = cast entity.getComp("ControlC");
			if (control != null) {
				var move:MoveC = cast entity.getComp("MoveC");
				_cursor.moveTo(cast move.location.x, cast move.location.y);
				break;
			}
		}
		add(_cursor);

		_state = "select";
		FlxG.camera.setScrollBoundsRect(0, 0, _level.tilemap.width, _level.tilemap.height, true);
		FlxG.camera.follow(_cursor, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.antialiasing = true;

		Text.loadFont("default0", "assets/font/default0.png", "assets/font/default0.fnt");
		Text.loadFont("default1", "assets/font/default1.png", "assets/font/default1.fnt");
		Text.loadFont("default2", "assets/font/default2.png", "assets/font/default2.fnt");
		Text.loadFont("default3", "assets/font/default3.png", "assets/font/default3.fnt");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (_menu != null && _menu.enabled) return;

		var nextTile:IntPoint = new IntPoint();
		var oldTile:IntPoint = new IntPoint();

		if (_state == "select" || _state == "move") {
			nextTile.copy(_cursor.selectedTile);
			oldTile.copy(_cursor.selectedTile);
			if (Input.map.justRelLeft) nextTile.set(_cursor.selectedTile.x - 1, _cursor.selectedTile.y);
			if (Input.map.justRelRight) nextTile.set(_cursor.selectedTile.x + 1, _cursor.selectedTile.y);
			if (Input.map.justRelUp) nextTile.set(_cursor.selectedTile.x, _cursor.selectedTile.y - 1);
			if (Input.map.justRelDown) nextTile.set(_cursor.selectedTile.x, _cursor.selectedTile.y + 1);
		}

		if (_state == "move") {
			for (p in _level.validMovePoints)
				if (p.equals(nextTile))
					_cursor.moveTo(cast nextTile.x, cast nextTile.y);

			if (Input.map.justRelZ) {
				_level.doneMoving();
				_menu.kill();
				remove(_menu, true);
				var a:Act = new Act(Act.MOVE);
				a.entityId = _selectedEntity.id;
				a.loc.copy(_cursor.selectedTile);
				performAct(a);
			}
		}

		if (_state == "select") {
			_cursor.moveTo(cast nextTile.x, cast nextTile.y);
			if (Input.map.justRelZ) selectEntity(findEntityOn(cast _cursor.selectedTile.x, cast _cursor.selectedTile.y));
		}
	}

	private function findEntityOn(x:Int, y:Int):Entity {
		for (entity in _entityGroup) if (entity.getComp("MoveC").location.x == x && entity.getComp("MoveC").location.y == y)
			return entity;
		return null;
	}

	private function selectEntity(entity:Entity):Void {
		if (entity == null) return;
		_selectedEntity = entity;
		_menu = new GameMenu(entity);
		_menu.menuExit = menuExit;
		add(_menu);
	}

	private function menuExit(type:String):Void {
		_state = type;

		if (_state == "move") {
			_level.createMoveGrid(_selectedEntity);
		}

		if (_state == "item action") {
			var a:Act = _menu.act;
			trace(a.entityId, a.itemId, a.actionId, a.patternId);
			performAct(a);
			_menu.kill();
			remove(_menu, true);
		}
	}

	private function performAct(a:Act):Void {
		_state = "acting";
		a.resolve(_entityGroup.members);
		if (a.type == Act.MOVE) {
			var path:Path = _level.findPath(new IntPoint(a.loc.x, a.loc.y));
			var delay:Float = findEntityId(a.entityId).getComp("MoveC").walk(path);
			new FlxTimer().start(delay, function(t:FlxTimer):Void{_state = "select";});
		}

		if (a.type == Act.ITEM_ACTION) {
			_level.doneMoving();
			var anim:CombatAnim = new CombatAnim(a);
			FlxG.camera.flash(0xFFFFFFFF, 1);
			new FlxTimer().start(1, function(t:FlxTimer):Void{_state = "select";});
		}
	}

	private function findEntityId(id:Int):Entity {
		for (entity in _entityGroup) if (entity.id == id) return entity;
		return null;
	}
}
