extends Node

@onready var Player = preload("res://Scenes/player.tscn")
@onready var singleton = get_node("/root/Singleton")
@onready var cloudTimer = $Timer
@onready var plCloud = preload("res://Scenes/cloud.tscn")

var playersAlive
var players: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	playersAlive = singleton.playerCount
	for i in singleton.playerCount:
		var player = Player.instantiate()
		player.playerNum = i
		player.main = self
		player.global_position = Vector2(randi_range(500, 1000), randi_range(100,700))
		add_child(player)
		players.append(player)
		

func player_dies(player):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in players.size():
		var this_player = players[i]
		var player_rects = this_player.queue_rects
		$UI.update_queue_sprites(i, player_rects)
	
	
func _on_timer_timeout():
	cloudTimer.wait_time = randf_range(15,25)
	var cloud = plCloud.instantiate()
	add_child(cloud)
	cloud.global_position = Vector2 (0, randi_range(0,650))
	
