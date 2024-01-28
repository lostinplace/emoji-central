extends CharacterBody2D

@onready var singleton = get_node("/root/Singleton")
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var arrow = $Sprite2D2
@onready var fireDelayTimer = $fireDelay
@export var firingDelay: float

@onready var regenDelay = $regenDelay
var damageMod = 1.0 #for events dont touch this
var speedMod = 1.0 #for events dont touch this

@export var regen = 1.5 #amount of time (seconds) it takes to regenerate 1 hp
var weaknesses = []
var main
var keyboard = false
var keyboard2 = false
var controllerID = 0

var playerNum = 0
var lastLooked = Vector2(1, 0)
var life = 70
var ghost = false
@onready var sprite = $Sprite2D
@onready var animPlayer = $AnimationPlayer
@onready var plBullet = preload("res://Scenes/bullet.tscn")
var my_state_machine

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
	if controllerID == 5:
		keyboard2 = true
	sprite.frame = 6 + (playerNum * 9)
	arrow.frame = playerNum
	if has_meta("author"):
		PlayerNumber = get_meta("PlayerNumber")
		print(PlayerNumber)
	
	var spritesheet = preload("res://Scripts/bullet_spritesheet.gd")
	var tmp_category = spritesheet.get_unused_category()
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

var sense_of_humor

func get_category():
	return my_joke_hopper.my_category["category"]

var audio_tools = preload("res://Scripts/audio_tools.gd")


func damage(dmg):
	life -= dmg
	sprite.frame = life/10 + (9 * playerNum)
	if life > 69:
		life = 70
		sprite.frame = 6 + (playerNum * 9)
	if life < 1:
		if ghost == false:
			main.player_dies(playerNum)
		ghost = true
		sprite.frame = 8 + (9 * playerNum)
		return
	if dmg > 0:
		animPlayer.stop()
		animPlayer.play("damage_flash")
	var st = get_tree()
	audio_tools.play_audio_for_duration(st, $DamageAudio, 0, 500)
	
	




func _input(event):
	if !frozen:
		if event.is_action_pressed("shoot2") and ghost != true and keyboard2 == true and fireDelayTimer.is_stopped() or event.is_action_pressed("shoot") and ghost != true and keyboard == true and fireDelayTimer.is_stopped() or Input.is_joy_button_pressed(controllerID, JOY_BUTTON_A) and fireDelayTimer.is_stopped() and ghost != true:
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
			bullet.velocity = lastLooked.normalized()
	if event.is_action_pressed("ui_cancel"):
		damage(10)

func _process(_delta):
	arrow.rotation = lastLooked.angle() - deg_to_rad(90)

func _physics_process(_delta):
	
	if !frozen:
		#movement
		var direction = Vector2.ZERO
		velocity= Vector2.ZERO;
		direction.x -= Input.get_joy_axis(controllerID, JOY_AXIS_LEFT_X) *-1
		direction.y -= Input.get_joy_axis(controllerID, JOY_AXIS_LEFT_Y) *-1

		if keyboard2 == true:
			direction = Vector2(Input.get_axis("left2", "right2"), Input.get_axis("up2", "down2"))
			direction = direction.normalized()

		if keyboard == true:
			direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
			direction = direction.normalized()
		
		#if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_LEFT):
			#direction.x -= 1
		#if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_RIGHT):
			#direction.x += 1
		#if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_UP):
			#direction.y -= 1
		#if Input.is_joy_button_pressed(controllerID, JOY_BUTTON_DPAD_DOWN):
			#direction.y += 1
		if direction:
			velocity = direction * SPEED
			lastLooked = direction

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletsGroup") :
		print(body)
		var impacting_joke_type = body.joke.Category
		var my_category = my_joke_hopper.my_category["category"]
		if my_category == impacting_joke_type:
			damage(10);
		body.queue_free();
	if body.is_in_group("alien"):
		damage(22)
		body.queue_free()
	 # Replace with function body.

		
	 # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("PowerupGroup") :
		print(area.spriteFrame)
		
		var spriteFrame = area.spriteFrame;
		area.queue_free();
		#Heart
		if(spriteFrame == 72):
			#Heal some health
			print("heal")
			life += 10
			if life >= 70:
				life = 70;
				sprite.frame = 6 + (playerNum * 9)
			else:
				print(life)
				sprite.frame = life/10 + (9 * playerNum)
			
		
		# ice block
		if(spriteFrame == 73):
			print("slip")
			# take away control for a few seconds
			frozen = true;
			await get_tree().create_timer(1.5).timeout
			frozen = false
			
		#shot/running
		if(spriteFrame == 75):
			SPEED*=1.5;
			await get_tree().create_timer(3).timeout
			SPEED = 300;
			
			
		
		#cheese trap
		if(spriteFrame == 76):
			velocity= Vector2.ZERO;
			#Stop all movement
			frozen = true;
			await get_tree().create_timer(2).timeout
			frozen = false


		
		

		#74 shield
		#75 shot
		#77 timer
		#78 bandaid
		#79 magnet
		#80 skull
		
		print("hit powerup")

