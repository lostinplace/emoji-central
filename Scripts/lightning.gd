extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fallandexplode")
	$Thunder.play()
	global_position = Vector2(randi_range(300, 1600), randi_range(100, 980))
	await get_tree().create_timer(4).timeout
	$CollisionShape2D.disabled = false
	$Thunder.play()
	await get_tree().create_timer(0.2).timeout
	$CollisionShape2D.disabled = true
	$Thunder.play()
	await get_tree().create_timer(0.3).timeout
	$Thunder.play()
	await get_tree().create_timer(0.5).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.damage(25)
