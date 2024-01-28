extends Area2D

var velocity
<<<<<<< Updated upstream
=======
var speed = 8
@onready var sprite = $Sprite2D
@onready var outline = $Sprite2D2
>>>>>>> Stashed changes
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var gs = preload("res://Scripts/garbage_spritesheet.gd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

<<<<<<< Updated upstream
=======
func change_outline_color(color):
	outline.modulate = color

var bounceCount = 0
const maxBounces = 4
var joke

>>>>>>> Stashed changes
func _physics_process(delta):
	global_position += velocity * delta

var jt = preload("res://Scripts/JokeTypes.gd")

var JokeTypes = jt.JokeTypes

var my_joketype = -1

func set_joketype(type: int):
	my_joketype = type
	var row = floor(type/4)
	var col = type % 4
	
	
	
	var rect = gs.get_sprite_rect(row, col)
	$Sprite2D.region_rect = rect
	$Sprite2D2.region_rect = rect
	
	
