class_name GameplayEventBus
extends Node


signal player_killed
signal end_goal_reached
signal player_warp_needed (level_id, spawnpoint)
signal do_pickup


static var bus : GameplayEventBus


func _ready() -> void:
    bus = self