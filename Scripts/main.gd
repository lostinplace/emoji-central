extends Node

@onready var Player = preload("res://Scenes/player.tscn")
@onready var singleton = get_node("/root/Singleton")
@onready var cloudTimer = $Timer
@onready var plCloud = preload("res://Scenes/cloud.tscn")
@onready var winScreen = preload("res://Scenes/menus/gameover.tscn")

var playersAlive = []
var players: Array
var bs = preload("res://Scripts/bullet_spritesheet.gd")

static var weakness_colors : Dictionary = {}
static var player_colors: Dictionary = {
	0: "FF000088",
	1: "0000FF88",
	2: "FFFF0088",
	3: "00FF0088"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_cat_names = bs.get_random_category_names()
	for i in singleton.playerCount:
		var player = Player.instantiate()
		player.playerNum = i
		playersAlive.append(i)
		player.main = self
		player.global_position = Vector2(randi_range(500, 1800), randi_range(100,950))
		add_child(player)
		player.set_jokehopper(random_cat_names[i])
		players.append(player)
		var player_color = player_colors[i]
		weakness_colors[random_cat_names[i]] = player_color
		var player_category = player.get_category()
		$UI.set_player_vulnerability(i, player_category)
		

func player_dies(player):
	playersAlive.erase(player)
	if playersAlive.size() == 1:
		singleton.winner = playersAlive.front()
		get_tree().change_scene_to_packed(winScreen)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	for i in players.size():
		var this_player = players[i]
		var player_rects = this_player.queue_rects
		$UI.update_queue_sprites(i, player_rects)
		
	
	
func _on_timer_timeout():
	cloudTimer.wait_time = randf_range(15,25)
	var cloud = plCloud.instantiate()
	add_child(cloud)
	cloud.global_position = Vector2 (0, randi_range(0,650))
	
