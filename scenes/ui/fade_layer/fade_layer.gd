extends CanvasLayer


signal fade_complete


func fade_in() -> void:
	$ColorRect.anchor_left = 0.0
	$ColorRect.anchor_right = 1.0
	var tween = create_tween()
	tween.tween_property($ColorRect, "anchor_left", 1.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): fade_complete.emit())

func fade_out() -> void:
	$ColorRect.anchor_left = 0.0
	$ColorRect.anchor_right = 0.0
	var tween = create_tween()
	tween.tween_property($ColorRect, "anchor_right", 1.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): fade_complete.emit())
