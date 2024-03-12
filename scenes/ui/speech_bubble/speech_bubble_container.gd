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


var await_input := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current = self
	GameplayEventBus.bus.player_warp_needed.connect(hide_text.unbind(2))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and current_state == States.AWAITING_INPUT:
		current_state = States.HIDDEN
		visible = false
		text_accepted.emit()
		return
	if event.is_action_pressed("jump") and current_state == States.SHOWING_TEXT:
		tween.stop()
		$Label.visible_ratio = 1.0
		if await_input: current_state = States.AWAITING_INPUT
		return


func hide_text() -> void:
	current_state = States.HIDDEN
	visible = false


func show_text(text : String, show_time : float, show_position : Vector2, do_await_input := false) -> void:
	visible = true
	await_input = do_await_input 

	var local_position = show_position - reference_viewport.get_visible_rect().position
	local_position.x = local_position.x / reference_viewport.get_visible_rect().size.x
	local_position.y = local_position.y / reference_viewport.get_visible_rect().size.y

	anchor_left = local_position.x
	anchor_right = local_position.x
	anchor_top = local_position.y
	anchor_bottom = local_position.y

	$Label.text = tr(text)
	$Label.visible_ratio = 0.0

	if tween: tween.stop()
	tween = create_tween()
	tween.tween_property($Label, "visible_ratio", 1.0, show_time)
	if await_input: tween.tween_callback(func(): current_state = States.AWAITING_INPUT)

	current_state = States.SHOWING_TEXT