extends Node


var Player1_Sprites: Array[Sprite2D]

@onready var countdownText = $Countdown;

# Called when the node enters the scene tree for the first time.
func _ready():
	countdownText.text=("3")
	await get_tree().create_timer(1).timeout
	countdownText.text=("2")
	await get_tree().create_timer(1).timeout
	countdownText.text=("1")
	await get_tree().create_timer(1).timeout
	countdownText.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_queue_sprites(player: int, rects :Array[Rect2]):
	var panel_name = "P{i}Panel".format({"i":player})
	var panel = get_node(panel_name)
	panel.update_queue_sprites(rects)
