class_name FlagTester
extends Node


@export var flag : String
@export var desired_value : bool = true
@export var expected_value : bool = false


func _ready() -> void:
    if not GameDataManager.current_game_data.flags.get(flag, expected_value) == desired_value:
        queue_free()