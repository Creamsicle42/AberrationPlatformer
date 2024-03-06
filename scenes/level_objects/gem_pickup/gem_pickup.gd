class_name GemPickup
extends Area2D


@export var pickup_id : String
@export var acceleration := 256.0
@export var max_speed := 256.0
@export var acceleration_max_dist := 64.0
@export var acceleration_curve : Curve
@export var friction := 1.0


var is_moving := false
var collector : Node2D

var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collected = GameDataManager.current_game_data.flags.get(
		get_flag(),
		false
	)
	if collected : queue_free()
	body_entered.connect(
		func(body):
			is_moving = true
			collector = body
	)
	GameplayEventBus.bus.do_pickup.connect(collect)
	print_debug(get_flag())


func _physics_process(delta: float) -> void:
	if not is_moving : return


	var move_delta = (collector.global_position - global_position)
	var acc_power = acceleration_curve.sample(clamp(move_delta.length() / acceleration_max_dist, 0.0, 1.0))

	velocity += move_delta.normalized() * acc_power * acceleration * delta
	velocity = velocity.limit_length(max_speed)

	velocity -= velocity * friction * delta

	global_position += velocity * delta


func collect() -> void:
	if not is_moving: return
	GameDataManager.current_game_data.flags[get_flag()] = true
	GameDataManager.current_game_data.flags["gems_collected"] = GameDataManager.current_game_data.flags.get("gems_collected", 0) + 1
	is_moving = false
	var tween = create_tween()
	tween.tween_property(self, "global_position", collector.global_position, 0.1)
	tween.tween_callback(queue_free)



func get_flag() -> String:
	return "%s/is_collected" % pickup_id
	
