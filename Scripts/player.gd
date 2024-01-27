extends CharacterBody2D

@onready var singleton = get_node("/root/Singleton")
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var arrow = $Sprite2D2
@onready var fireDelayTimer = $fireDelay
@export var firingDelay: float

var keyboard = false
var controllerID = 0
var playerNum = 0
var lastLooked = Vector2(1, 0)
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
var queue_rects: Array[Rect2]

var frozen = false

func _ready():
	
	PlayerNumber = get_meta("PlayerNumber")
	print(PlayerNumber)
	if playerNum == 0:
		controllerID = singleton.player1
	elif playerNum == 1:
		controllerID = singleton.player2
	elif playerNum == 2:
		controllerID = singleton.player3
	elif playerNum == 3:
		controllerID = singleton.player4
	if controllerID == 4:
		keyboard = true
	sprite.frame = playerNum * 9
	arrow.frame = playerNum
	if has_meta("author"):
		PlayerNumber = get_meta("PlayerNumber")
		print(PlayerNumber)
		
	my_sense_of_humor = psm.get_sense_of_humor("Dark")
	my_joke_hopper = JokeHopper.new(my_sense_of_humor.joke_distribution, 5)
	queue_rects = my_joke_hopper.get_sprite_rects()


func damage(dmg):
	life -= dmg
	sprite.frame = (80 - life)/10 + (9 * playerNum)
	if life < 1:
		sprite.frame = 7 + (9 * playerNum)
		return
	animPlayer.stop()
	animPlayer.play("damage_flash")


func _input(event):
	if !frozen:
		if event.is_action_pressed("shoot") and keyboard == true and fireDelayTimer.is_stopped() or Input.is_joy_button_pressed(controllerID, JOY_BUTTON_A) and fireDelayTimer.is_stopped():
			var next_joke = my_joke_hopper.dequeue_joke()
			var bullet = plBullet.instantiate()
			fireDelayTimer.start(firingDelay)
			bullet.bulletOwner = self
			bullet.set_joketype(next_joke)
			queue_rects = my_joke_hopper.get_sprite_rects()
			bullet.global_position = global_position
			get_tree().current_scene.add_child(bullet)
			bullet.velocity = lastLooked
	if event.is_action_pressed("ui_cancel"):
		damage(10)

func _process(delta):
	arrow.rotation = lastLooked.angle() - deg_to_rad(90)

func _physics_process(delta):
	#movement
	var direction = Vector2.ZERO
	velocity= Vector2.ZERO;
	if keyboard == true:
		direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_LEFT):
		direction.x -= 1
	if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_RIGHT):
		direction.x += 1
	if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_UP):
		direction.y -= 1
	if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_DOWN):
		direction.y += 1
	if direction:
		velocity = direction.normalized() * SPEED
		lastLooked = direction

	

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletsGroup") :
		print(body)
		if body.bulletOwner != self:
			damage(10);
			body.queue_free();
	 # Replace with function body.
