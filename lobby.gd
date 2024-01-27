extends Control

@onready var main = preload("res://Scenes/main.tscn")
@onready var singleton = get_node("/root/Singleton")

var controllersPlaying = []
var keyboardConnected = false
@onready var label1 = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var label4 = $Label4
var players = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	singleton.player1 = null
	singleton.player2 = null
	singleton.player3 = null
	singleton.player4 = null
	singleton.playerCount = 0

func _input(event):
	if event.is_action_pressed("shoot") or event.is_action_pressed("controllerShoot"):
		for i in controllersPlaying.size():
			if Input.is_joy_button_pressed(controllersPlaying[i], JOY_BUTTON_A):
				return
		for c in Input.get_connected_joypads().size():
			if Input.is_joy_button_pressed(c, JOY_BUTTON_A):
				controllersPlaying.append(c)
				new_player_joined(c)
				return
		if keyboardConnected == false:
			keyboardConnected = true
			new_player_joined(4)

func new_player_joined(ID):
	if players == 0:
		label1.text = str("Connected with device ", ID)
		singleton.player1 = ID
	elif players == 1:
		label2.text = str("Connected with device ", ID)
		singleton.player2 = ID
	elif players == 2:
		label3.text = str("Connected with device ", ID)
		singleton.player3 = ID
	elif players == 3:
		label4.text = str("Connected with device ", ID)
		singleton.player4 = ID
	players += 1
	singleton.playerCount += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(main)
