extends Node

@onready
var tileMap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func to_tile(pos):
	return Vector2i(floor(pos.x/32),floor(pos.y/32))
	
func get_data(pos):
	return tileMap.get_cell_tile_data(0,pos)

func change_tile(pos,to):
	tileMap.set_cell(0,pos,0,to) 
	
func change_terrain(pos,to):
	tileMap.set_cells_terrain_connect (0,pos,0,to) 
