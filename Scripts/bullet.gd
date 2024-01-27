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

func _physics_process(delta):
	global_position += velocity * speed

var jt = preload("res://Scripts/JokeTypes.gd")

var JokeTypes = jt.JokeTypes

var my_joketype = -1

func set_joketype(type: int):
	my_joketype = type
	var row = floor(type/4)
	var col = type % 4
	
	
	
	var rect = gs.get_sprite_rect(row, col)
	$Sprite2D.region_rect = rect
	
