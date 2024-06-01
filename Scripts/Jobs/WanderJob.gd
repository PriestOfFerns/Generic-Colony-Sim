class_name WanderJob extends Job


var rng = RandomNumberGenerator.new()

func _init():
	type="Wander"

func tick(colonist, reached, pathfinder, tilemaster):
	if target == null:
		target = Vector2i(-1,-1)
		while !pathfinder.is_valid(target):
			target = tilemaster.to_tile(colonist.position)+Vector2i(rng.randi_range(-3,3),rng.randi_range(-3,3))			
			rng.randomize()
	if reached:
		return false		
	
	return target
