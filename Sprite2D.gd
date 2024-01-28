extends Sprite2D

var spriteFrame = 72;


@onready var powerup = $Powerup
# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	
	var randomNumber = rand.randi_range(72,81)
	spriteFrame = randomNumber;
	powerup.frame = randomNumber;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
