class_name GameCamera
extends Camera2D


static var camera : GameCamera

var track_node : Node2D


func _ready() -> void:
	camera = self


func _process(_delta: float) -> void:
	if track_node != null:
		global_position = track_node.global_position


