class_name GameplayEventBus
extends Node


signal player_killed
signal end_goal_reached


static var bus : GameplayEventBus


func _ready() -> void:
    bus = self