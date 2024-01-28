extends Node2D




var spriteFrame = 75;
@onready var powerupSprite = $PowerupSprite




# Called when the node enters the scene tree for the first time.
func _ready():
	spriteFrame = powerupSprite.frame;
	var rand = RandomNumberGenerator.new()
	
	var randomNumber = rand.randi_range(72,81)
	#spriteFrame = randomNumber;
	#powerupSprite.frame = randomNumber;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	# powerups dissappear after 5 seconds
	queue_free()
	pass # Replace with function body.
