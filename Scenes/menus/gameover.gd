extends Control

@onready var singleton = get_node("/root/Singleton")
@onready var mainmenu = load("res://Scenes/menus/mainmenu.tscn")
@onready var lobby = load("res://Scenes/menus/lobby.tscn")
@onready var main = load("res://Scenes/main.tscn")

func _ready():
	$Label.text = str("P", singleton.winner, " WINS!!")
	$Winner.frame = 9*singleton.winner

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(mainmenu)

func _on_button_2_pressed():
	get_tree().change_scene_to_packed(main)



func _on_play_again_pressed():
	get_tree().change_scene_to_packed(main)


func _on_main_menu_pressed():
	get_tree().change_scene_to_packed(lobby)
