extends Node

@onready
var tileMaster = $"%TileMaster"

@export
var startPos = Vector2i(0,0)
@export
var sizeX = 0
@export
var sizeY = 0

var update = 0

var do_update = false

var astar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	gen_map()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (do_update):
		gen_map()
	

func is_valid(p_cords):
	return p_cords.x>=0 and p_cords.y>=0 and tileMaster.get_data(p_cords) != null and tileMaster.get_data(p_cords).get_custom_data("walkability")>0

var neighs = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]

func get_id(pos):
	return pos.x+pos.y*sizeX

func get_pos(id):
	return Vector2i(id%sizeX,id/sizeX)

func gen_map():
	update+=1
	astar.clear()
	for y in range(sizeY):
		for x in range(sizeX):
			var pos = Vector2i(x,y)
			
			if (is_valid(pos)):
				
				astar.add_point(get_id(pos),pos,2-(tileMaster.get_data(pos).get_custom_data("walkability"))/100)
	for y in range(sizeY):
		for x in range(sizeX):
			var pos = Vector2i(x,y)
			if is_valid(pos):
				for z in neighs:
					if  is_valid(pos+z):
						
						astar.connect_points(get_id(pos),get_id(pos+z))

func gen_path(from,to):
	return astar.get_point_path(get_id(from),get_id(to))

