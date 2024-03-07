class_name MenuParalaxElement
extends TextureRect


@export var power := 4.0 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos := get_viewport().get_mouse_position() + (get_viewport_rect().size * 0.5)
	var offset := Vector2(mouse_pos.x / get_viewport_rect().size.x, mouse_pos.y / get_viewport_rect().size.y)
	offset_left = offset.x * power
	offset_right = offset.x * power
	offset_top = offset.y * power
	offset_bottom = offset.y * power