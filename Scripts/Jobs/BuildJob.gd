class_name BuildJob extends Job



var building: Build




func _init():
	type="Build"
	
	
func genPath(colonist, pathfinder, tilemaster):
	var possiblePaths = []
	for x in [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]:
		var next = building.position + x
		if pathfinder.is_valid(next):
			possiblePaths.append([next,pathfinder.gen_path(tilemaster.to_tile(colonist.position),next)])
	if len(possiblePaths)>0:
		var min_path = 9223372036854775807
		var choice
		for x in possiblePaths:
			if len(x[1]) < min_path:
				min_path = len(x[1])
				choice = x
		target = choice[0]
		path = choice[1]

func tick(colonist, reached, pathfinder, tilemaster):
	if target==null:
		genPath(colonist, pathfinder, tilemaster)
		
	if (reached):
		if (building.buildProgress>=building.buildNeeded):
			building.on_build(tilemaster)
			building.built=true
			pathfinder.gen_map()
			return ["done"]
		building.buildProgress+=20
	else: return ["goto",path[1]]
	return ["wait"]
