extends CharacterBody2D


const SPEED = 300.0
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var playerNum = 0
var lastLooked: Vector2
var playerNum = 2
var lastLooked = Vector2(1,0)
var life = 70
@onready var sprite = $Sprite2D
@onready var arrow = $arrow
@onready var animPlayer = $AnimationPlayer
@onready var plBullet = preload("res://Scenes/bullet.tscn")

func _ready():
	sprite.frame = playerNum * 8
	arrow.frame = playerNum

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#damage function
func damage(dmg):
	life -= dmg
	sprite.frame = int(80 - life/10)
	sprite.frame = ((80 - life)/10) + (8 * playerNum)
	if life < 1:
		sprite.frame = 7 + (8 * playerNum)
		return
	animPlayer.stop()
	animPlayer.play("damage_flash")

func _input(event):
	if event.is_action_pressed("shoot"):
		var bullet = plBullet.instantiate()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		bullet.velocity = lastLooked
	#this is a temp keybind to test damage
	if event.is_action_pressed("ui_cancel"):
		damage(10)

func _process(delta):
	arrow.rotation = lastLooked.angle() - deg_to_rad(90)

func _physics_process(delta):
	#movement
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	if direction:
		velocity = direction * SPEED
		lastLooked = velocity
	else:
		velocity= Vector2.ZERO;
	

	move_and_slide()
