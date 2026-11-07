extends Node3D

@export var move_speed: float = 4.0
@export var jump_force: float = 6.0
@export var follow_distance: float = 10.0
@export var random_move_interval: float = 1.5
@export var gravity: float = 9.8

var move_velocity: Vector3 = Vector3.ZERO
var player: Node3D
var random_direction: Vector3 = Vector3.ZERO
var time_since_random: float = 0.0
var vertical_speed: float = 0.0
var on_floor: bool = true

func _ready():
	# Change this path to match your scene
	player = get_node("/root/Main/Player")

func _process(delta):
	if not player:
		return

	var to_player = player.global_transform.origin - global_transform.origin
	var distance = to_player.length()

	if distance < follow_distance:
		var follow_dir = to_player.normalized()
		move_velocity.x = follow_dir.x * move_speed
		move_velocity.z = follow_dir.z * move_speed
	else:
		time_since_random += delta
		if time_since_random >= random_move_interval:
			random_direction = Vector3(
				randf() * 2 - 1,
				0,
				randf() * 2 - 1
			).normalized()
			time_since_random = 0.0

		move_velocity.x = random_direction.x * move_speed
		move_velocity.z = random_direction.z * move_speed

	if on_floor and randf() < 0.02:
		vertical_speed = jump_force
		on_floor = false

	if not on_floor:
		vertical_speed -= gravity * delta
		if global_transform.origin.y <= 0:
			global_transform.origin.y = 0
			vertical_speed = 0
			on_floor = true

	translate(Vector3(move_velocity.x, vertical_speed, move_velocity.z) * delta)
