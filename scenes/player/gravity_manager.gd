class_name GravityManager
extends Node


@export var gravity_influences : Array[GravityAreaData]


func get_gravity_direction() -> Vector2:
    return gravity_influences.front().up_direction


func get_graivty_scale() -> float:
    return gravity_influences.front().gravity_scale


func add_influence(influence : GravityAreaData) -> void:
    if gravity_influences.has(influence): return
    gravity_influences.push_front(influence)


func remove_influence(influince : GravityAreaData) -> void:
    gravity_influences.erase(influince)