class_name SpeechEvent
extends LevelEvent


@export_multiline var text : String
@export_range(0, 0.5, 0.01) var charachter_time : float = 0.025
@export var bubble_pos : Vector2
@export var await_input_at_end := true


func execute(_data : Dictionary) -> void:
	SpeechBubbleContainer.current.show_text(text, text.length() * charachter_time, bubble_pos, await_input_at_end)
	if await_input_at_end: await SpeechBubbleContainer.current.text_accepted
