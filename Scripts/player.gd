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

func _ready():

	my_sense_of_humor = psm.get_sense_of_humor("Dark")
	my_joke_hopper = JokeHopper.new(my_sense_of_humor.joke_distribution, 5)

var sense_of_humor

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
		bullet.bulletOwner = self
		bullet.set_joketype(next_joke)
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


func _on_area_2d_body_entered(body):
	if body.is_in_group("BulletGroup") :
		if body.bulletOwner != self:
			damage(10);
			body.queue_free();
	 # Replace with function body.
