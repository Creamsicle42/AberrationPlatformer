class_name SpeechBubbleContainer
extends PanelContainer


signal text_accepted


enum States {
	HIDDEN,
	SHOWING_TEXT,
	AWAITING_INPUT
}


@export var reference_viewport : SubViewport
static var current : SpeechBubbleContainer
var current_state : States
var tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and current_state == States.AWAITING_INPUT:
		current_state = States.HIDDEN
		visible = false
		text_accepted.emit()


func show_text(text : String, show_time : float, global_position : Vector2) -> void:
	visible = true

	var local_position = global_position - reference_viewport.get_visible_rect().position
	local_position.x = local_position.x / reference_viewport.get_visible_rect().size.x
	local_position.y = local_position.y / reference_viewport.get_visible_rect().size.y

	anchor_left = local_position.x
	anchor_right = local_position.x
	anchor_top = local_position.y
	anchor_bottom = local_position.y

	$Label.text = text

	current_state = States.AWAITING_INPUT