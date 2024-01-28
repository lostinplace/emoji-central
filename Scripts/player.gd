extends CharacterBody2D

@onready var singleton = get_node("/root/Singleton")
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var arrow = $Sprite2D2
@onready var fireDelayTimer = $fireDelay
@export var firingDelay: float

var main
var keyboard = false
var controllerID = 0
var playerNum = 0
var lastLooked = Vector2(1, 0)
var life = 70
var ghost = false
@onready var sprite = $Sprite2D
@onready var animPlayer = $AnimationPlayer
@onready var plBullet = preload("res://Scenes/bullet.tscn")

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
	sprite.frame = 6 + (playerNum * 9)
	arrow.frame = playerNum
	if has_meta("author"):
		PlayerNumber = get_meta("PlayerNumber")
		print(PlayerNumber)
	
	var tmp_category = preload("res://Scripts/bullet_spritesheet.gd").get_random_category()
	var tmp_cat_name = tmp_category.category
	my_joke_hopper = JokeHopper.new(tmp_cat_name, 5)
	queue_rects = my_joke_hopper.get_sprite_rects()
	
	frozen = true;
	
	await get_tree().create_timer(3).timeout
	frozen = false

func get_category():
	return my_joke_hopper.my_category["category"]

func damage(dmg):
	life -= dmg
	sprite.frame = life/10 + (9 * playerNum)
	if life < 1:
		if ghost == false:
			main.player_dies(playerNum)
		ghost = true
		sprite.frame = 8 + (9 * playerNum)
		return
	animPlayer.stop()
	animPlayer.play("damage_flash")
	play_audio_for_duration(my_stream, 490.0, 1400.0)


func _input(event):
	if !frozen:
		if event.is_action_pressed("shoot") and ghost != true and keyboard == true and fireDelayTimer.is_stopped() or Input.is_joy_button_pressed(controllerID, JOY_BUTTON_A) and fireDelayTimer.is_stopped() and ghost != true:
			var next_joke = my_joke_hopper.dequeue_joke()
			var bullet = plBullet.instantiate()
			fireDelayTimer.start(firingDelay)
			bullet.set_joketype(next_joke)
			queue_rects = my_joke_hopper.get_sprite_rects()
			var bullet_position = global_position + lastLooked * 40
			bullet.global_position = bullet_position
			
			get_tree().current_scene.add_child(bullet)
			bullet.velocity = lastLooked
	if event.is_action_pressed("ui_cancel"):
		damage(10)

func _process(delta):
	arrow.rotation = lastLooked.angle() - deg_to_rad(90)

func _physics_process(delta):
	
	if !frozen:
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
 
var my_stream = load("res://Assets/Sounds/cartoon-laugh-6457.mp3")

func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletsGroup") :
		print(body)
		var impacting_joke_type = body.joke.Category
		var my_category = my_joke_hopper.my_category["category"]
		if my_category == impacting_joke_type:
			damage(10);
			play_audio_for_duration(my_stream, 490.0, 1400.0)
		body.queue_free();
	 # Replace with function body.
		

# This method plays an audio stream for a specific duration from a given offset
func play_audio_for_duration(stream, offset_ms: float, duration_s):
	# Assuming 'audio_player' is the name of your AudioStreamPlayer node
	var audio_player = $audio_player

	# Load the stream and set the start offset
	audio_player.stream = stream
	#var sp = audio_player.play()
	#sp.seek(offset_ms * 0.001) # Convert ms to seconds

	# Start playing the audio
	audio_player.play(offset_ms * 0.001)

	# Set a timer to stop playback after the duration
	await get_tree().create_timer(duration_s * 0.001).timeout
	audio_player.stop()

	# Example usage

#var my_stream = load("res://path_to_your_mp3_file.mp3")
#play_audio_for_duration(my_stream, 5000, 10) # Play 10 seconds of audio starting at 5000ms
