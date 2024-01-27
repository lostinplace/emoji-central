extends Node2D


enum PlayerStates {
	FINE,
	GIGGLING,
	LAUGHING_TO_DEATH
}

var current_state = PlayerStates.FINE

func _ready():
	set_process(true)

func _process(delta):
	match current_state:
		PlayerStates.FINE:
			handle_fine_state()
		PlayerStates.GIGGLING:
			handle_giggling_state()
		PlayerStates.LAUGHING_TO_DEATH:
			handle_laughing_to_death_state()


func handle_fine_state():
	# Logic for the fine state
	pass
	

func handle_giggling_state():
	# Logic for the giggling state
	pass


func handle_laughing_to_death_state():
	# Logic for the laughing to death state
	pass


func change_state(new_state):
	current_state = new_state
	# Any additional logic when changing state


class SenseOfHumor:
	var name: String
	var description: String
	var joke_distribution: Dictionary

	func _init(_name: String, _description: String, _joke_distribution: Dictionary):
		name = _name
		description = _description
		joke_distribution = _joke_distribution


static func get_sense_of_humor(name: String):
	var jt = preload("res://Scripts/JokeTypes.gd")
	var JokeTypes = jt.JokeTypes
	
	var dark_sense_of_humor = SenseOfHumor.new(
			"Dark", 
			"You laugh at the misfortune of others.", 
				{
					JokeTypes.DARK_HUMOR: 1, 
					JokeTypes.LIGHT_HUMOR: 1, 
				}
		)
	
	var pet_humor = SenseOfHumor.new(
		"Pets",
		"You laugh at the misfortune of others.",
			{
				JokeTypes.CAT_JOKE: 5,
				JokeTypes.DOG_JOKE: 5,
				JokeTypes.DAD_JOKE: 1,
			}
	)
	
	var senses_of_humor = {
		"Dark": dark_sense_of_humor,
		"Pets": pet_humor
	}
	return senses_of_humor[name]
