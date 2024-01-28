extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var progressBar = $Panel/ProgressBar
@onready var timer = $Timer
@onready var progressBarLabel = $Panel/Label
@onready var bigLabel = $Label
@onready var blackout = $blackout
@onready var main = get_parent()
@onready var plMeteor = preload("res://Scenes/lightning.tscn")
@onready var plAliens = preload("res://Scenes/alien.tscn")
@onready var alienNode = $alienNode
var state = 0
var events = ["blackout", "aliens!", "lightning shower", "double damage", "1.5x speed"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		progressBar.value = timer.wait_time - timer.time_left
	elif state == 2:
		progressBar.value = timer.time_left

func aliens():
	for i in 8:
		var alien = plAliens.instantiate()
		alienNode.add_child(alien)

func lightning_shower(): #it says meteor because it was a meteor and i dont feel like fixing it
	for i in 4:
		for g in 7:
			var meteor = plMeteor.instantiate()
			main.add_child(meteor)
		await get_tree().create_timer(4).timeout

func _on_timer_timeout():
	if state == 0:
		events.shuffle()
		progressBarLabel.text = events.front()
		bigLabel.text = events.front()
		animPlayer.play("timer_drop")
		progressBar.max_value = 10
		state = 1
		timer.start(10)
	elif state == 1:
		timer.start(20)
		if events.front() == "double damage":
			for i in main.players.size():
				main.players[i].damageMod = 2.0
		elif events.front() == "1.5x speed":
			for i in main.players.size():
				main.players[i].speedMod = 1.5
		elif events.front() == "lightning shower":
			lightning_shower()
		elif events.front() == "aliens!":
			aliens()
		elif events.front() == "blackout":
			blackout.visible = true
			progressBar.max_value = 4
			timer.start(4)
		progressBar.max_value = 20
		animPlayer.play("event")
		state = 2
		
	elif state == 2:
		if events.front() == "double damage":
			for i in main.players.size():
				main.players[i].damageMod = 1.0
		elif events.front() == "1.5x speed":
			for i in main.players.size():
				main.players[i].speedMod = 1.0
		elif events.front() == "blackout":
			blackout.visible = false
		elif events.front() == "aliens!":
			for i in alienNode.get_child_count():
				alienNode.get_child(i).queue_free()
		animPlayer.play("timer_hide")
		state = 0
		timer.start(30)
