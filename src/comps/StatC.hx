package comps;

class StatC extends Comp
{
	public var stats:Stats;
	public var ailments:Array<Ailment>;
	public var hp:Int;
	public var ap:Int;
	public var dead:Bool = false;

	public function new(entity:Entity) {
		super(entity);
		name = "StatC";

		hp = 10;
		ap = 10;
		dead = false;
		stats = {};
		ailments = [];
	}

	public function damage(amount:Int):Void {
		hp -= amount;
	}
}

typedef Stats = { 
}

typedef Ailment = { 
}
