extends RigidBody2D

var velocity
var speed = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var gs = preload("res://Scripts/garbage_spritesheet.gd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var bounceCount = 0
const maxBounces = 4

func _physics_process(delta):

	global_position += velocity * speed
	var collisionInfo = move_and_collide(velocity*delta)
	if collisionInfo:
		print("bounce")
		velocity = velocity.bounce(collisionInfo.get_normal())
		bounceCount += 1
	
	if bounceCount > maxBounces:
		# destroy self
		queue_free()
		

var jt = preload("res://Scripts/JokeTypes.gd")

var JokeTypes = jt.JokeTypes

var my_joketype = -1

func set_joketype(my_joketype: int):
	var rect = gs.get_sprite_rect(my_joketype)
	$Sprite2D.region_rect = rect
	


