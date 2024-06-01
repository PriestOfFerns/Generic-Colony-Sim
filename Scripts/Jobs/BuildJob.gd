class_name BuildJob extends Job



var building: Build




func _init():
	priority=2
	type="Build"
	

func tick(colonist, reached, pathfinder, tilemaster):
	if target==null:
		var possiblePaths = []
		for x in [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]:
			var next = building.position + x
			if pathfinder.is_valid(next):
				possiblePaths.append([next,len(pathfinder.gen_path(tilemaster.to_tile(colonist.position),next))])
		if len(possiblePaths)>0:
			var min = 999
			var choice
			for x in possiblePaths:
				if x[1]<min:
					min = x[1]
					choice = x[0]
			target = choice
			
		else:
			return false

		
	if (reached):
		if (building.buildProgress>=building.buildNeeded):
			building.on_build(tilemaster)
			building.built=true
			pathfinder.gen_map()
			return false
		building.buildProgress+=1
		
	

	return target
