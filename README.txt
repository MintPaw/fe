GameObject =>
	Item => wear:Int, age:Int, actions:Array<Action>, exp:Int, expTillNext:Int, clone():Item, use(action:Action):Void

	Entity => ap:Int, hp:Int, location:Point
		Unit => dead:Bool, items:Array<Item>, move(loc:Array<Point>):Void, Action:Array<Ailment>, stats:Stats

	Action => name:String, description:String, pattern:Pattern, damage:Point, accuracy:Point, splah:Bool

	Pattern => grid:Array<Point>, directions:Array<Direction>

	Stats => maxHp:Int, armour:Float, magicResist:Float
	// How do stats work? Item? On player? Leveling? Ratios? Pure? Spell chances

	Direction => { LEFT, RIGHT, UP, DOWN }
