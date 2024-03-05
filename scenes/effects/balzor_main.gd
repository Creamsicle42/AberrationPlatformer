extends Sprite2D


var starting_x : float
var starting_y : float
var time : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_x = position.x
	starting_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position.x = starting_x + sin(time) * 8
	position.y = starting_y + sin(time * 2.12) * 4
