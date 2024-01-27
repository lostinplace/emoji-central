extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var lastLooked: Vector2
@onready var plBullet = preload("res://Scenes/bullet.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	if event.is_action_pressed("shoot"):
		var bullet = plBullet.instantiate()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		bullet.velocity = lastLooked

func _physics_process(delta):
	#movement
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction:
		velocity = direction * SPEED
		lastLooked = velocity
	else:
		velocity= Vector2.ZERO;
	

	move_and_slide()
