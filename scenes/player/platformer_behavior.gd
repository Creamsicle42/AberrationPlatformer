class_name PlatformerBehavior
extends Node


@export var max_run_speed := 256.0
@export var ground_acceleration_time := 0.1
@export var air_acceleration_time := 0.2
@export var apex_threshold := 64.0


@export var jump_height := 200.0
@export var jump_time := 0.3
@export var coyote_time := 0.1
@export var wall_touch_time := 0.2
@export var jump_buffer_time := 0.1
@export var terminal_velocity := 1000.0
@export var apex_gravity_modifier := 0.75


@onready var host : CharacterBody2D = owner as CharacterBody2D


var ground_acceleration : float
var air_acceleration : float
var gravity : float
var jump_power : float
var coyote_timer : float
var jump_buffer_timer : float
var wall_touch_timer : float
var last_wall_touched : Vector2


func _ready() -> void:
    gravity = jump_height / (2 * pow(jump_time, 2))
    jump_power = -sqrt(2 * jump_height * gravity)
    ground_acceleration = max_run_speed / ground_acceleration_time
    air_acceleration = max_run_speed / air_acceleration_time


func _physics_process(delta: float) -> void:
    coyote_timer -= delta
    jump_buffer_timer -= delta
    wall_touch_timer -= delta

    var h_input = Input.get_axis("left", "right")

    host.velocity.x = move_toward(host.velocity.x, max_run_speed * h_input, get_acceleration() * delta)
    host.velocity.y += get_gravity() * delta

    if host.is_on_wall_only():
        wall_touch_timer = wall_touch_time
        last_wall_touched = host.get_wall_normal()


    if host.is_on_floor():
        coyote_timer = coyote_time

    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer_time

    if (coyote_timer > 0.0 or wall_touch_timer > 0.0) and jump_buffer_timer > 0.0:
        var jump_dir = get_jump_normal()
        if wall_touch_timer > 0.0:
            jump_dir += last_wall_touched
        jump_dir = jump_dir.normalized()

        coyote_timer = 0
        jump_buffer_timer = 0
        wall_touch_timer = 0

        host.velocity.y = jump_power * -jump_dir.y
        host.velocity.x += jump_power * -jump_dir.x
    
    host.velocity.y = clamp(host.velocity.y, -INF, terminal_velocity)

    host.move_and_slide()


func get_jump_normal() -> Vector2:
    return Vector2.UP


func get_acceleration() -> float:
    return ground_acceleration if abs(host.velocity.y) < apex_threshold else air_acceleration


func get_gravity() -> float:
    return gravity \
        * (1.0 if Input.is_action_pressed("jump") and host.velocity.y < 0 else 2.0) \
        * (1.0 if abs(host.velocity.y) > apex_threshold else apex_gravity_modifier)