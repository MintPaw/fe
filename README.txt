Todo:
	Refactor cursor

	Item => name:String, description:String, id:Int, wear:Int, age:Int, actions:Array<Action>, exp:Int, expTillNext:Int, clone():Item, use(action:Action):Void, nextId:Int

	Unit => ap:Int, items:Array<Item>, move(loc:Array<Point>):Void, ailments:Array<Ailment>, stats:Stats, hp:Int, location:Point, attackable:Bool, dead:Bool, drops:Array<Item>

	Action => name:String, description:String, patterns:Pattern, damage:Point, accuracy:Point, splah:Bool

	Pattern => grid:Array<Point>, name:String, description:String

	Stats => maxHp:Int, armour:Float, magicResist:Float
	// How do stats work? Item? On player? Leveling? Ratios? Pure? Spell chances
