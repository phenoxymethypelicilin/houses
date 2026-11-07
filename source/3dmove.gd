class_name Player
extends CharacterBody3D
@export var speed := 15.0
@export var jump_speed := 6.0
@export var mouse_sensitivity := 0.002
@onready var cam = $Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var pitch := 0.0
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# Rotate player horizontally (yaw)
		rotate_y(-event.relative.x * mouse_sensitivity)
		# Rotate camera vertically (pitch) with clamping
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg_to_rad(-70), deg_to_rad(70))
		cam.rotation.x = pitch
func _physics_process(delta):
	velocity.y += -gravity * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	if is_on_floor() and Input.is_action_just_pressed("ui_select"):
		velocity.y = jump_speed
	move_and_slide()
