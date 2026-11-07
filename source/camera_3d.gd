extends Camera3D
var startPOS : Vector3
var bobt : float = 0
@export var playeridle : float
@export var player : Player
@export var camerabobbing : float 
@export var bobspeed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startPOS = self.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.is_on_floor():
		bobt = bobt + (player.velocity.length() + playeridle) * delta
	var yoffset = sin(bobt*bobspeed)*camerabobbing
	self.position.y = startPOS.y + yoffset
	pass
