class_name PlatformerBehavior
extends Node


@export_group("Horizontal")
@export var max_run_speed := 256.0
@export var ground_acceleration_time := 0.1
@export var air_acceleration_time := 0.2
@export var apex_threshold := 64.0
@export var dash_power := 1.25
@export var dash_time := 1.5


@export_group("Jumping")
@export var jump_height := 200.0
@export var jump_time := 0.3
@export var coyote_time := 0.1
@export var wall_touch_time := 0.2
@export var jump_buffer_time := 0.1
@export var terminal_velocity := 1000.0
@export var apex_gravity_modifier := 0.75
@export var wall_jump_control_loss_time := 0.1
@export var wall_bonk_velocity_ratio = 1.0
@export var bounce_orb_touch_area : Area2D
@export var bounce_orb_touch_time := 0.1



@export_group("CielBonking", "bonk_")
@export var bonk_left_raycast : RayCast2D
@export var bonk_center_raycast : RayCast2D
@export var bonk_right_raycast : RayCast2D
@export var bonk_velocity := 400.0


@export_group("Misc")
@export var gravity_manager : GravityManager
@export var air_drag : float = 1.0


@export_group("Animation")
@export var sprite : AnimatedSprite2D
@export var vertical_velocity_range := 64.0
@export var run_dust_particles : CPUParticles2D
@export var dash_dust_particles : CPUParticles2D
@export var jump_trail_particles : CPUParticles2D
@export var dust_cloud_particles : PackedScene


@onready var host : CharacterBody2D = owner as CharacterBody2D


var jump_anim_tween : Tween
var ground_acceleration : float
var air_acceleration : float
var gravity : float
var jump_power : float
var coyote_timer : float
var jump_buffer_timer : float
var wall_touch_timer : float
var last_wall_touched : Vector2
var wall_jump_controll_loss_timer : float
var on_wall_last_frame : bool
var last_bounce_orb_touched : BounceOrb
var bounce_orb_touch_timer : float
var dash_timer : float


func _ready() -> void:
	
	gravity = jump_height / (2 * pow(jump_time, 2))
	jump_power = -sqrt(2 * jump_height * gravity)
	ground_acceleration = max_run_speed / ground_acceleration_time
	air_acceleration = max_run_speed / air_acceleration_time


func _physics_process(delta: float) -> void:
	coyote_timer -= delta
	jump_buffer_timer -= delta
	wall_touch_timer -= delta
	wall_jump_controll_loss_timer -= delta
	bounce_orb_touch_timer -= delta

	var h_input = Input.get_axis("left", "right")

	if not wall_jump_controll_loss_timer > 0.0:
		host.velocity.x = move_toward(host.velocity.x, max_run_speed * h_input * (dash_power if dash_timer <= 0.0 else 1.0)
		, get_acceleration() * delta)
	host.velocity += get_gravity() * delta * gravity_manager.get_graivty_scale() * gravity_manager.get_gravity_direction()

	host.up_direction = -1 * gravity_manager.get_gravity_direction()
	bonk_center_raycast.target_position = -14 * gravity_manager.get_gravity_direction()
	bonk_right_raycast.target_position = -14 * gravity_manager.get_gravity_direction()
	bonk_left_raycast.target_position = -14 * gravity_manager.get_gravity_direction()

	if host.is_on_wall_only():
		wall_touch_timer = wall_touch_time
		last_wall_touched = host.get_wall_normal()

	if (max_run_speed - abs(host.velocity.x)) < 5.0 and host.is_on_floor():
		dash_timer -= delta
	
	if abs(host.velocity.x) < 16.0:
		dash_timer = clamp(dash_timer + delta, 0, dash_time)

	run_dust_particles.emitting = host.is_on_floor() and abs(host.velocity.x) / 10.0
	dash_dust_particles.emitting = host.is_on_floor() and abs(host.velocity.x) / 10.0 and dash_timer <= 0.0


	if host.is_on_floor():
		coyote_timer = coyote_time

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	

	if not bounce_orb_touch_area.get_overlapping_areas().is_empty():
		last_bounce_orb_touched = bounce_orb_touch_area.get_overlapping_areas()[0]
		bounce_orb_touch_timer = bounce_orb_touch_time

	if (coyote_timer > 0.0 or wall_touch_timer > 0.0 or bounce_orb_touch_timer > 0.0) and jump_buffer_timer > 0.0:
		var jump_dir = get_jump_normal()
		if wall_touch_timer > 0.0:
			jump_dir += last_wall_touched * 1.25
			wall_jump_controll_loss_timer = wall_jump_control_loss_time
			dash_timer = 0.0
		jump_dir = jump_dir.normalized()

		if bounce_orb_touch_timer > 0.0:
			bounce_orb_touch_timer = 0.0
			last_bounce_orb_touched.use_orb()


		jump_trail_particles.emitting = true
		var dust_cloud :CPUParticles2D= dust_cloud_particles.instantiate()

		host.get_parent().add_child(dust_cloud)
		dust_cloud.global_position = jump_trail_particles.global_position
		dust_cloud.emitting = true
		get_tree().create_timer(1.0).timeout.connect(dust_cloud.queue_free)

		coyote_timer = 0
		jump_buffer_timer = 0
		wall_touch_timer = 0

		host.velocity.y = jump_power * -jump_dir.y * gravity_manager.get_gravity_direction().y
		host.velocity.x += jump_power * -jump_dir.x

		sprite.scale = Vector2(0.5, 1.5)
		if jump_anim_tween:
			jump_anim_tween.kill()
		jump_anim_tween = create_tween()
		jump_anim_tween.tween_property(sprite, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	

	if host.velocity.y < 0.0 and not bonk_center_raycast.is_colliding():
		host.move_and_collide(
			Vector2((int(bonk_left_raycast.is_colliding()) - int(bonk_right_raycast.is_colliding())) * bonk_velocity * delta, 0)
		)
	

	if not host.is_on_floor():
		host.velocity -= air_drag * host.velocity * delta

	
	host.velocity.y = clamp(host.velocity.y, -INF, terminal_velocity)

	var prev_x_velocity := host.velocity.x
	var prev_y_velocity := host.velocity.y

	host.move_and_slide()

	if host.is_on_wall() \
			and (not on_wall_last_frame) \
			and (not host.is_on_floor()) :
		host.velocity.y += -abs(prev_x_velocity) * wall_bonk_velocity_ratio * gravity_manager.get_gravity_direction().y

	on_wall_last_frame = host.is_on_wall()

	if host.is_on_floor() and prev_y_velocity > 128.0:
		var dust_cloud :CPUParticles2D= dust_cloud_particles.instantiate()
		host.get_parent().add_child(dust_cloud)
		dust_cloud.global_position = jump_trail_particles.global_position
		dust_cloud.emitting = true
		get_tree().create_timer(1.0).timeout.connect(dust_cloud.queue_free)


	if host.is_on_floor():
		sprite.speed_scale = 1.0
		if abs(host.velocity.x) > 5.0:
			sprite.play("run")
			
		else:
			sprite.play("idle")
	else:
		sprite.animation = "in_air"
		sprite.frame = round(clamp(host.velocity.y / vertical_velocity_range, -1, 1)) + 1


func get_jump_normal() -> Vector2:
	return Vector2.UP


func get_acceleration() -> float:
	return ground_acceleration if abs(host.velocity.y) < apex_threshold else air_acceleration


func get_gravity() -> float:
	return gravity \
		* (1.0 if Input.is_action_pressed("jump") and host.velocity.y * gravity_manager.get_gravity_direction().y < 0 else 2.0) \
		* (1.0 if abs(host.velocity.y) > apex_threshold else apex_gravity_modifier)
