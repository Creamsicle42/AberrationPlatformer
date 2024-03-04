class_name SpeechBubbleContainer
extends PanelContainer


enum States {
	HIDDEN,
	SHOWING_TEXT,
	AWAITING_INPUT
}


static var current : SpeechBubbleContainer
var current_state : States
var tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
