class_name CutsceneSlideLayer
extends CanvasLayer


signal text_accepted
signal fade_complete


enum States {
	HIDDEN,
	SHOWING_TEXT,
	AWAITING_INPUT
}


static var current : CutsceneSlideLayer 


var tween : Tween
var state := States.HIDDEN
@onready var back : PanelContainer = $Back as PanelContainer
@onready var text : RichTextLabel = $Back/CenterContainer/VBoxContainer/SlideText as RichTextLabel
@onready var image : TextureRect = $Back/CenterContainer/VBoxContainer/SlideImage as TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and state == States.AWAITING_INPUT:
		text_accepted.emit()
		return
	if event.is_action_pressed("jump") and state == States.SHOWING_TEXT:
		tween.stop()
		text.visible_ratio = 1.0
		state = States.AWAITING_INPUT
		return


func quick_appear() -> void:
	back.modulate = Color(1.0, 1.0, 1.0, 1.0)


func quick_hide() -> void:
	back.modulate = Color(1.0, 1.0, 1.0, 0.0)


func fade_appear() -> void:
	var fade_tween := create_tween()
	fade_tween.tween_property(back, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0)
	fade_tween.tween_callback(func(): fade_complete.emit())


func fade_hide() -> void:
	var fade_tween := create_tween()
	fade_tween.tween_property(back, "modulate", Color(1.0, 1.0, 1.0, 0.0), 1.0)
	fade_tween.tween_callback(func(): fade_complete.emit())


func show_slide(slide_image : Texture2D, slide_text : String, display_time : float) -> void:
	image.texture = slide_image
	text.text = slide_text

	text.visible_ratio = 0
	if tween: tween.stop()
	tween = create_tween()
	tween.tween_property(text, "visible_ratio", 1.0, display_time)
	tween.tween_callback(func(): state = States.AWAITING_INPUT)

	state = States.SHOWING_TEXT