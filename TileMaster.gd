extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func to_tile(p_cords):
	return Vector2i(floor(p_cords.x/32),floor(p_cords.y/32))
	
func get_data(p_cords):
	return $TileMap.get_cell_tile_data(0,p_cords)
