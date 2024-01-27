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
	
#func update_queue_sprites(player: int, rects: Array[Rect2]):
	#for i in rects.size():
		#var index =i+1 
		#var player_indicator = "p" + str(player)
		#var format_string = "{pi}_box/q{index}_border/sprite"
		#var format_dict = {
			#"pi": player_indicator,
			#"index": index
		#}
		#
		#var path = format_string.format(format_dict)
		#var node:Sprite2D = get_node(path)
		#if node == null:
			#continue
		#var this_rect = rects[i]
		#node.region_rect = this_rect


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_queue_sprites(player: int, rects :Array[Rect2]):
	var panel_name = "P{i}Panel".format({"i":player})
	var panel = get_node(panel_name)
	panel.update_queue_sprites(rects)
