extends Node

@onready
var baseColonist = $"LittleGuy"
@onready
var colonistHolder = $"Colonists"
@onready
var tileMaster = $"%TileMaster"
@onready
var pathFinder = $"%Pathfinder"
@onready
var buildingHolder = $"%BuildManager/Builds"


func _ready():
	make_colonist("Dave",Vector2(16,16))

var update = 0



func shouldBuild(colonist):
	var jobs = []
	for building in buildingHolder.get_children():
		if (building.built == false and building.inProcess == false):
			var tempJob = BuildJob.new()
			tempJob.building = building
			tempJob.genPath(colonist,pathFinder,tileMaster)
			jobs.append(tempJob)
	var min_path = 9223372036854775807
	var finalJob
	for job in jobs:
		if len(job.path) > 0 and len(job.path)<min_path:
			finalJob = job
			min_path = len(job.path)
	if (finalJob):
		colonist.job=finalJob
		return true
	return false
	
func shouldWander(colonist):
	var job = WanderJob.new()
	var try = job.genPath(colonist,pathFinder,tileMaster)
	if (try):
		colonist.job = job
		return true
	return false
		
func _physics_process(delta):
	for colonist in colonistHolder.get_children():
		if colonist.walkProgress != 0:
			lerpColonist(colonist,colonist.target,delta)
		else:
			var not_stuck = true
			if shouldBuild(colonist): pass
			elif shouldWander(colonist): pass
			else: not_stuck = false
			
			if not_stuck:
				var response = colonist.job.tick(colonist,hasReached(colonist),pathFinder,tileMaster)
				if response[0]=="done":
					colonist.job = null
				elif response[0]=="goto":
					var goto = Vector2(response[1].x*32+16,response[1].y*32+16)
					colonist.target = goto
					colonist.was = colonist.position
					colonist.walkProgress = 1
				
			
		
func hasReached(colonist):
	return colonist.job.target==tileMaster.to_tile(colonist.position)

func lerpColonist(colonist, toBe,t):
	colonist.walkProgress+=300*t
	colonist.position = colonist.was.lerp(toBe,colonist.walkProgress/50)
	if colonist.walkProgress >= 50:
		colonist.walkProgress = 0.00


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
