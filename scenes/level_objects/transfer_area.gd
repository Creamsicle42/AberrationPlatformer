class_name TransferArea
extends Area2D


@export var level_id : String
@export var spawnpoint_id : String


func _ready() -> void:
	body_entered.connect(
		(func(): GameplayEventBus.bus.player_warp_needed.emit(level_id, spawnpoint_id)).unbind(1)
	)


