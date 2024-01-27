extends Node

var Player1
var UINode
@onready var Player = preload("res://Scenes/player.tscn")
@onready var singleton = get_node("/root/Singleton")

var players: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in singleton.playerCount:
		var player = Player.instantiate()
		player.playerNum = i
		player.global_position = Vector2(randi_range(500, 1000), randi_range(100,700))
		add_child(player)
		players.append(player)
		
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in players.size():
		var this_player = players[i]
		var player_rects = this_player.queue_rects
		$UI.update_queue_sprites(i, player_rects)
	
	

