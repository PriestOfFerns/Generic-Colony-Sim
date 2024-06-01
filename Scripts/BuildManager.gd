extends Node

@onready
var buildsContainer = $Builds
@onready
var tileMaster = $"%TileMaster"


func _ready():
	for x in range(10):
		createBuild(WallBuild,Vector2i(5,x))
		createBuild(WallBuild,Vector2i(7,x))
	pass # Replace with function body.



func _process(delta):
	pass


func createBuild(type,pos):
	var build = type.new()
	build.position = pos
	buildsContainer.add_child(build)
	
	build.on_blueprint(tileMaster)
