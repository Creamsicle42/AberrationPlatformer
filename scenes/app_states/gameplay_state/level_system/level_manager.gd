class_name LevelManager
extends Node


## LevelManager, controlls instancing of levels
##
## Keeps track of what the current level is, and handles resetting it, and moving to the next level when needed


@export var level_parent : Node
@export var levels : Array[LevelData]


var current_level_resource : LevelData
var current_level_node : LevelController


## Sets the current level to the given index
func set_level_index(index : int) -> void:
	current_level_resource = levels[index]


## Instances the current level as a child of the level parent, frees curent level if there is any
func instance_current_level() -> void:
	assert(current_level_resource != null, "Cannot instance level, no current level assigned.")
	if current_level_node != null:
		current_level_node.queue_free()
	
	current_level_node = current_level_resource.level_scene.instantiate()

	assert(current_level_node is LevelController, "Level node for resource \"%s\" is not a LevelController" % current_level_resource.name)

	level_parent.add_child.call_deferred(current_level_node)


## Sets the current level resource to the next one in sequence.
##  If at the end of sequence returns false and sets level resource to null.
func advance_level() -> bool:
	assert(current_level_resource != null, "Cannot advance level, no current level assigned.")
	var current_index = levels.find(current_level_resource)
	var next_index = current_index + 1

	if next_index >= levels.size(): 
		current_level_resource = null
		return false


	current_level_resource = levels[next_index]
	return true
