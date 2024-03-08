extends AnimatableBody2D



func _on_player_detector_body_entered() -> void:
	$AnimationPlayer.play("shake")
	$ShakeParticles.emitting = true
	$Shake.play()