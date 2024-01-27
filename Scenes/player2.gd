extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var playerNum = 0
var lastLooked: Vector2
var life = 70
@onready var sprite = $Sprite2D
@onready var animPlayer = $AnimationPlayer
@onready var plBullet = preload("res://Scenes/bullet.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func damage(dmg):
	life -= dmg
	sprite.frame = int(80 - life/10)
	if life < 1:
		return
	animPlayer.stop()
	animPlayer.play("damage_flash")

func _input(event):
	if event.is_action_pressed("controllerShoot"):
		var bullet = plBullet.instantiate()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		bullet.velocity = lastLooked
	if event.is_action_pressed("ui_cancel"):
		damage(10)

func _physics_process(delta):
	#movement
	var direction = Vector2(Input.get_axis("controllerLeft", "controllerRight"), Input.get_axis("controllerUp", "controllerDown"))
	if direction:
		velocity = direction * SPEED
		lastLooked = velocity
	else:
		velocity= Vector2.ZERO;
	

	move_and_slide()
