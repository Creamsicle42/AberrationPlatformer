class_name BounceOrb
extends Area2D



func _ready() -> void:
	$BounceOrb.play("glow")


func use_orb() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$BounceOrb.play("die")
	$RefreshTimer.start()
	$BurstParticles.emitting = true
	$IdleParticles.emitting = false



func _on_refresh_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$BounceOrb.play("glow")
	$ReformParticles.emitting = true
	$IdleParticles.emitting = true