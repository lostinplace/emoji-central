extends CharacterBody2D

<<<<<<< Updated upstream

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

=======
@onready var singleton = get_node("/root/Singleton")
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var arrow = $Sprite2D2
@onready var fireDelayTimer = $fireDelay
@onready var regenDelay = $regenDelay
@export var firingDelay: float
var damageMod = 1.0 #for events dont touch this
var speedMod = 1.0 #for events dont touch this

@export var regen = 1.5 #amount of time (seconds) it takes to regenerate 1 hp
var weaknesses = []
var main
var keyboard = false
var controllerID = 0
>>>>>>> Stashed changes
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

func _ready():
<<<<<<< Updated upstream
=======
	
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
	get_tree()
	for i in main.players.size():
		weaknesses.append(main.players[i].get_category())
	frozen = false
	regenDelay.start(regen)
>>>>>>> Stashed changes

	my_sense_of_humor = psm.get_sense_of_humor("Dark")
	my_joke_hopper = JokeHopper.new(my_sense_of_humor.joke_distribution, 5)

var sense_of_humor

func damage(dmg):
	life -= dmg
<<<<<<< Updated upstream
	sprite.frame = int(80 - life/10)
=======
	sprite.frame = life/10 + (9 * playerNum)
	if life > 69:
		life = 70
		sprite.frame = 6 + (playerNum * 9)
>>>>>>> Stashed changes
	if life < 1:
		return
	if dmg > 0:
		animPlayer.stop()
		animPlayer.play("damage_flash")

func _input(event):
<<<<<<< Updated upstream
	if event.is_action_pressed("shoot"):
		var next_joke = my_joke_hopper.dequeue_joke()
		
		var bullet = plBullet.instantiate()
		bullet.set_joketype(next_joke)
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		bullet.velocity = lastLooked
=======
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
			for w in weaknesses.size():
				if weaknesses[w] == next_joke.Category:
					if w == 0:
						bullet.change_outline_color("ff0000")
					elif w == 1:
						bullet.change_outline_color("0000ff")
					elif w == 2:
						bullet.change_outline_color("ffff00")
					elif w == 3:
						bullet.change_outline_color("00ff00")
					
			bullet.velocity = lastLooked
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
	

	move_and_slide()
=======
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
			velocity = direction.normalized() * SPEED * speedMod
			lastLooked = direction

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletsGroup") :
		print(body)
		var impacting_joke_type = body.joke.Category
		var my_category = my_joke_hopper.my_category["category"]
		if my_category == impacting_joke_type:
			damage(22 * damageMod);
		body.queue_free();
	if body.is_in_group("alien"):
		damage(22)
		body.queue_free()
	 # Replace with function body.

		
#	extends Node


## This method plays an audio stream for a specific duration from a given offset
#func play_audio_for_duration(stream, offset_ms, duration_s):
#	# Assuming 'audio_player' is the name of your AudioStreamPlayer node
#	var audio_player = $audio_player
#
#	# Load the stream and set the start offset
#	audio_player.stream = stream
#	audio_player.stream_playback.seek(offset_ms * 0.001) # Convert ms to seconds
#
#	# Start playing the audio
#	audio_player.play()
#
#	# Set a timer to stop playback after the duration
#	yield(get_tree().create_timer(duration_s), "timeout")
#	audio_player.stop()
#
#	# Example usage
#	func _ready():
#	var my_stream = load("res://path_to_your_mp3_file.mp3")
#	play_audio_for_duration(my_stream, 5000, 10) # Play 10 seconds of audio starting at 5000ms


func _on_regen_delay_timeout():
	damage(-1)
>>>>>>> Stashed changes
