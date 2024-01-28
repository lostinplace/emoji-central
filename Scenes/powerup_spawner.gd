extends Node


var powerup_pl = preload("res://Scenes/powerup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_powerup_spawner_timer_timeout():
	var powerup = powerup_pl.instantiate()
	get_tree().current_scene.add_child(powerup)
	powerup.global_position = Vector2(randi_range(300, 700), randi_range(100,1000))

	pass # Replace with function body.
