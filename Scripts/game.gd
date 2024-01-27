extends Node

var Player1
var UINode

# Called when the node enters the scene tree for the first time.
func _ready():
	Player1 = get_node("Player1")
	var Player1_rects = Player1.queue_rects
	$UI.update_queue_sprites(1, Player1_rects)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Player1_rects = Player1.queue_rects
	$UI.update_queue_sprites(1, Player1_rects)
	
