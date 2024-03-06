extends Sprite2D



var time : float


func _ready() -> void:
	time = randf_range(0.0, 10.0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta

	position.y += sin(time) * delta
	rotation = (Player.player.global_position - global_position).angle()
