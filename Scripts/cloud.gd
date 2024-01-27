extends Sprite2D

@onready var speed=randi_range(5,10)

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = randi_range(0,3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += speed*delta
	if global_position.x > 1920:
		queue_free()
