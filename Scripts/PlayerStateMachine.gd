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
	var icon_path: String

	func _init(_name: String, _description: String, _joke_distribution: Dictionary, _icon_path: String):
		name = _name
		description = _description
		joke_distribution = _joke_distribution
		icon_path = _icon_path





