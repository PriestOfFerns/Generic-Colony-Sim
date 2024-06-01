class_name WallBuild extends Build

var terrainId = 0

func _init():
	buildNeeded=100

func on_build(tileMaster):
	tileMaster.change_terrain([position],terrainId) 
