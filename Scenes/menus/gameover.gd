extends Control

@onready var singleton = get_node("/root/Singleton")
@onready var mainmenu = preload("res://Scenes/menus/mainmenu.tscn")
@onready var main = preload("res://Scenes/main.tscn")

func _ready():
	$Label.text = str("P", singleton.winner, " WINS!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(mainmenu)


func _on_button_2_pressed():
	get_tree().change_scene_to_packed(main)
