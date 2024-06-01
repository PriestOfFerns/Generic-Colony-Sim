extends Node

@onready
var baseColonist = $"LittleGuy"
@onready
var colonistHolder = $"Colonists"
@onready
var tileMaster = $"%TileMaster"
@onready
var pathFinder = $"%Pathfinder"

# Called when the node enters the scene tree for the first time.
func _ready():
	make_colonist("Dave",Vector2(16,16))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for colonist in colonistHolder.get_children():
		if (colonist.job==null):
			var wander = WanderJob.new()
			colonist.job = wander
		else:
			if (colonist.target):
				
				if (colonist.walkProgress<50):
					colonist.walkProgress+=delta*200
					

					colonist.position = colonist.was.lerp(colonist.target,colonist.walkProgress/50)
					
				else:
					colonist.target = null
					colonist.was = null
					colonist.walkProgress=0
			else:
				
				var reached = false
				if (colonist.job.target != null and tileMaster.to_tile(colonist.position) == colonist.job.target): reached = true
				var result = colonist.job.tick(colonist, reached,pathFinder,tileMaster)
				if result:
					var path = pathFinder.gen_path(tileMaster.to_tile(colonist.position),result)
					if (path and len(path)>1):
						
						colonist.target = Vector2(path[1].x*32+16,path[1].y*32+16)
						colonist.was = colonist.position
						
						if (colonist.target.x<colonist.was.x):
							colonist.flip_h = true
						else:
							colonist.flip_h = false
					else:
						colonist.job=null
				else:
					colonist.job = null
	



func get_id():
	return colonistHolder.get_child_count()

func make_colonist(p_name,p_pos):
	var clone = baseColonist.duplicate()
	colonistHolder.add_child(clone)
	clone.name = "C-"+str(get_id())
	clone.colonist_name = p_name
	clone.set_global_position(p_pos)
	clone.health=100
	clone.maxHealth=100
