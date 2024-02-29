class_name ExitGoal
extends Area2D


func _on_body_entered(body:Node2D) -> void:
	GameplayEventBus.bus.end_goal_reached.emit()
