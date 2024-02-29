class_name Player
extends CharacterBody2D



func killed() -> void:
    GameplayEventBus.bus.player_killed.emit()


func _on_hazard_hitbox_body_entered(_body:Node2D) -> void:
    killed()
