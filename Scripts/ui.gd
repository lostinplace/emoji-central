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
func _process(_delta):
	pass


func update_queue_sprites(player: int, rects :Array[Rect2]):
	var panel_name = "P{i}Panel".format({"i":player})
	var panel = get_node(panel_name)
	panel.update_queue_sprites(rects)

func set_player_vulnerability(player:int, player_category: String):
	var panel_name = "P{i}Panel".format({"i":player})
	var panel = get_node(panel_name)
	var v_rect = preload("res://Scripts/bullet_spritesheet.gd").get_category_rect(player_category)
	panel.get_node("Panel/vulnerable").region_rect= v_rect
