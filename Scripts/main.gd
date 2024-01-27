extends Node2D

@onready var plPlayer = preload("res://Scenes/player.tscn")
@onready var singleton = get_node("/root/Singleton")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in singleton.playerCount:
		var player = plPlayer.instantiate()
		player.playerNum = i
		player.global_position = Vector2(randi_range(500, 1000), randi_range(100,700))
		add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
