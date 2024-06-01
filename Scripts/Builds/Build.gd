class_name Build extends Node

var buildProgress = 0
var inProcess = false
var started = false
var built = false
var buildNeeded 
var position = Vector2i(0,0)

var blueprint_texture = Vector2i(17,0)

func on_build(tileMaster):
	pass 
	
func on_blueprint(tileMaster):
	tileMaster.change_tile(position,blueprint_texture)

