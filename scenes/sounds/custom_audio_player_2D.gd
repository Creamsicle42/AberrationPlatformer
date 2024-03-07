class_name CustomAudioPlayer2D
extends AudioStreamPlayer


@export var max_distance := 500
@export var position : Vector2
@export var falloff : Curve



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	volume_db = falloff.sample(position.distance_to(Player.player.global_position) / max_distance)
