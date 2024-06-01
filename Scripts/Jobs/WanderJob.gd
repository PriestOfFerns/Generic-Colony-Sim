class_name WanderJob extends Job


var rng = RandomNumberGenerator.new()

func _init():
	type="Wander"

func genPath(colonist, pathfinder, tilemaster):
	target = Vector2i(-1,-1)
	path = []
	var try = 0
	
	while !pathfinder.is_valid(target) or len(path) == 0:
		target = tilemaster.to_tile(colonist.position)+Vector2i(rng.randi_range(-3,3),rng.randi_range(-3,3))			
		path = pathfinder.gen_path(tilemaster.to_tile(colonist.position),target)
		try+=1
		if try > 20:
			return false
		rng.randomize()
	return true

func tick(colonist, reached, pathfinder, tilemaster):
	if target == null:
		genPath(colonist, pathfinder, tilemaster)
	if reached or len(path)<2:
		return ["done"]		
	
	return ["goto",path[1]]
