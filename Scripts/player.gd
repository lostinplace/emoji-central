extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var lastLooked: Vector2
@onready var 


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#movement
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if direction:
		velocity = direction * SPEED
		lastLooked = velocity
	else:
		velocity= Vector2.ZERO;
	

	move_and_slide()
