extends RigidBody2D

var bulletOwner

var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var gs = preload("res://Scripts/garbage_spritesheet.gd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	global_position += velocity * delta
	var collisionInfo = move_and_collide(velocity*delta)
	if collisionInfo:
		velocity = velocity.bounce(collisionInfo.get_normal())


var jt = preload("res://Scripts/JokeTypes.gd")

var JokeTypes = jt.JokeTypes

var my_joketype = -1

func set_joketype(type: int):
	my_joketype = type
	var row = floor(type/4)
	var col = type % 4
	
	
	
	var rect = gs.get_sprite_rect(row, col)
	$Sprite2D.region_rect = rect
	


