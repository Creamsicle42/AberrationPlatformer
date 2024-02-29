class_name Player
extends CharacterBody2D


func get_gravity_manager() -> GravityManager:
	return $GravityManager


func killed() -> void:
	print_debug("player killed")
	GameplayEventBus.bus.player_killed.emit()


func _on_hazard_hitbox_body_entered(_body:Node2D) -> void:
	killed()
