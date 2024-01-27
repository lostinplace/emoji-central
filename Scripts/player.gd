extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var playerNum = 0
var lastLooked: Vector2
var life = 70
@onready var sprite = $Sprite2D
@onready var animPlayer = $AnimationPlayer
@onready var plBullet = preload("res://Scenes/bullet.tscn")
var my_state_machine
var psm = preload("res://Scripts/PlayerStateMachine.gd")
var SenseOfHumor = psm.SenseOfHumor
var my_sense_of_humor
var JokeHopper = preload("res://Scripts/JokeHopper.gd").JokeHopper
var my_joke_hopper

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var PlayerNumber


func _ready():
	if has_meta("author"):
		PlayerNumber = get_meta("PlayerNumber")
		print(PlayerNumber)
		
	my_sense_of_humor = psm.get_sense_of_humor("Dark")
	my_joke_hopper = JokeHopper.new(my_sense_of_humor.joke_distribution, 5)


var sense_of_humor


func update_player_queue_control(rects: Array):
	for i in 3:
		var control_name = "p" + PlayerNumber + "_Queue" + i
		var SpriteNode = get_node(control_name)
		var this_rect = rects[i]
		SpriteNode.region_rect = this_rect


func damage(dmg):
	life -= dmg
	sprite.frame = int(80 - life/10)
	if life < 1:
		return
	animPlayer.stop()
	animPlayer.play("damage_flash")


func _input(event):
	if event.is_action_pressed("shoot"):
		var next_joke = my_joke_hopper.dequeue_joke()
		var bullet = plBullet.instantiate()
		bullet.set_joketype(next_joke)
		var sprite_rects: Array[Rect2] = my_joke_hopper.get_sprite_rects()
		update_player_queue_control(sprite_rects)
		
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		bullet.velocity = lastLooked
	if event.is_action_pressed("ui_cancel"):
		damage(10)


func _physics_process(delta):
	#movement
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction:
		velocity = direction * SPEED
		lastLooked = velocity
	else:
		velocity= Vector2.ZERO;

	move_and_slide()
