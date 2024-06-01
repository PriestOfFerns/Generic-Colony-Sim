extends Node

@onready
var baseColonist = $"LittleGuy"
@onready
var colonistHolder = $"Colonists"


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
			if (colonist.job.target == null or colonist.)
			colonist.job.tick(colonist, false)
	



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
