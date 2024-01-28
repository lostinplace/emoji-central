extends RigidBody2D

var velocity
var speed = 8
@onready var sprite = $Sprite2D
@onready var outline = $Sprite2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var bs = preload("res://Scripts/bullet_spritesheet.gd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_outline_color(color):
	outline.modulate = color

var bounceCount = 0
const maxBounces = 4
var joke

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

func set_joketype(_joke):
	joke = _joke
	var rect = bs.get_rect_for_joke(joke.JokeNumber, joke.Category)
	$Sprite2D.region_rect = rect
	$Sprite2D2.region_rect = rect
	
	
