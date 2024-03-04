class_name GemPickup
extends Area2D


@export var pickup_id : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collected = GameDataManager.current_game_data.flags.get(
		get_flag(),
		false
	)
	if collected : queue_free()
	body_entered.connect(collect.unbind(1))
	print_debug(get_flag())


func collect() -> void:
	GameDataManager.current_game_data.flags[get_flag()] = true
	GameDataManager.current_game_data.flags["gems_collected"] = GameDataManager.current_game_data.flags.get("gems_collected", 0) + 1
	queue_free()


func get_flag() -> String:
	return "%s/is_collected" % pickup_id
	