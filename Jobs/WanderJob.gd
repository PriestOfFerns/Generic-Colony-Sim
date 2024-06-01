class_name WanderJob extends Job

@onready
var tileMaster = $"%TileMaster"
@onready
var pathFinder = $"%Pathfinder"

var rng = RandomNumberGenerator.new()


func tick(colonist, reached):
	if target == null:
		target = Vector2i(-1,-1)
		while !pathFinder.is_valid(target):
			target = tileMaster.to_tile(colonist.Transform.position)+Vector2i(rng.randi_range(-3,3),rng.randi_range(-3,3))
			rng.randomize()
	if reached:
		return false		
	
	return target
