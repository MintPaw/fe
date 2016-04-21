package ;

import de.polygonal.ds.*;

class IntPoint implements Prioritizable implements Hashable {
	public var position:Int;
	public var priority:Float;
	public var key:Int;

	public var x:Int;
	public var y:Int;

	public function new(x:Float=0, y:Float=0) {
		set(x, y);
	}

	public function equals(other:IntPoint):Bool {
		return x == other.x && y == other.y;
	}

	public function clone():IntPoint {
		return new IntPoint(x, y);
	}

	public function copy(other:IntPoint):Void {
		x = other.x;
		y = other.y;
	}

	public function set(x:Float=0, y:Float=0) {
		this.x = Std.int(x);
		this.y = Std.int(y);
	}
}
