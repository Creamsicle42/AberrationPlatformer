class_name Player
extends CharacterBody2D


func _ready() -> void:
	await get_tree().process_frame
	GameCamera.camera.track_node = self


func _process(delta: float) -> void:
	$FlipPivot.scale.y = sign($GravityManager.get_gravity_direction().y)


func get_gravity_manager() -> GravityManager:
	return $GravityManager


func killed() -> void:
	print_debug("player killed")
	GameplayEventBus.bus.player_killed.emit()


func _on_hazard_hitbox_body_entered(_body:Node2D) -> void:
	killed()
