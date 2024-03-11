class_name LevelController
extends Node2D


signal player_placed 


@export var player : Player
@export var spawnpoints : Node


func spawn_player_at_point(spawnpoint_id : String) -> void:
	var adjusted_id = spawnpoint_id.to_pascal_case()
	player.global_position = spawnpoints.get_node(adjusted_id).global_position
	player_placed.emit()
