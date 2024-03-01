class_name GravityArea
extends Area2D


@export var gravity_data : GravityAreaData


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body : Node2D) -> void:
	if not body.has_method("get_gravity_manager"): return
	body.get_gravity_manager().add_influence(gravity_data)


func _on_body_exited(body : Node2D) -> void:
	if not body.has_method("get_gravity_manager"): return
	body.get_gravity_manager().remove_influence(gravity_data)
