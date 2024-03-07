class_name GemPickup
extends Area2D


@export var pickup_id : String
@export var acceleration := 256.0
@export var max_speed := 256.0
@export var acceleration_max_dist := 64.0
@export var acceleration_curve : Curve
@export var friction := 1.0
@export var follow_sound : AudioStream
@export var retrieve_sound : AudioStream


var time := 0.0
var is_moving := false
var played_sound := false
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
			

			if not played_sound:
				played_sound = true
				var player = AudioStreamPlayer.new()
				player.stream = follow_sound
				player.autoplay = true
				get_parent().add_child(player)
				player.play()
				player.finished.connect(player.queue_free)
			
	)
	GameplayEventBus.bus.do_pickup.connect(collect)
	print_debug(get_flag())


func _process(delta: float) -> void:
	time += delta
	$Sprite.position = 2 * Vector2(sin(time * 2) + cos(time * 3), cos(time * 2) + sin(time * 3))


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
	var tween = create_tween().parallel()
	tween.tween_property(self, "global_position", collector.global_position, 0.2)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2)
	tween.tween_callback(
		func():
			var player = AudioStreamPlayer.new()
			player.stream = retrieve_sound
			player.autoplay = true
			get_parent().add_child(player)
			player.play()
			player.finished.connect(player.queue_free)
	)
	tween.tween_callback(queue_free).set_delay(0.2)



func get_flag() -> String:
	return "%s/is_collected" % pickup_id
	
