extends RigidBody2D

var speed = randf_range(2.0,4.0)
var left = true
var frequency = randf_range(1.0,2.0)
var amplitude = randi_range(150,950)
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2(355, randi_range(0, 1080))

func _physics_process(delta):
	time += delta
	var movement = cos(time*frequency)*amplitude
	global_position.y += movement*delta
	if left:
		global_position.x += speed
	else:
		global_position.x -= speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if global_position.x > 1600:
		left = false
	if global_position.x < 350:
		left = true
