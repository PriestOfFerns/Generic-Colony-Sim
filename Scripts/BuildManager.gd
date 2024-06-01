extends Node

@onready
var buildsContainer = $Builds
@onready
var tileMaster = $"%TileMaster"
@onready
var pathFinder = $"%Pathfinder"


func _ready():
	for x in range(3):
		createBuild(WallBuild,Vector2i(5,x))
		createBuild(WallBuild,Vector2i(5,4+x))
		createBuild(WallBuild,Vector2i(7,x))
		createBuild(WallBuild,Vector2i(7,4+x))
		
		createBuild(WallBuild,Vector2i(9,x))
		createBuild(WallBuild,Vector2i(9,5+x))
		createBuild(WallBuild,Vector2i(11,x))
		createBuild(WallBuild,Vector2i(11,5+x))
	pathFinder.gen_map()
	pass # Replace with function body.



func _process(delta):
	pass


func createBuild(type,pos):
	var build = type.new()
	build.position = pos
	buildsContainer.add_child(build)
	
	build.on_blueprint(tileMaster)
