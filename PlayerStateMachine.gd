extends Node2D


enum PlayerStates {
	FINE,
	GIGGLING,
	LAUGHING_TO_DEATH
}


enum JokeTypes {
	DAD_JOKE,
	KNOCK_KNOCK,
	DARK_HUMOR,
	FART_JOKE,
	CAT_JOKE,
	DOG_JOKE
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



class JokeHopper:
	var joke_queue = []
	var joke_distribution: Dictionary

	func _init(_joke_distribution: Dictionary):
		joke_distribution = _joke_distribution
		refill_hopper()

	func dequeue_joke() -> int:
		if joke_queue.size() == 0:
			refill_hopper()
		return joke_queue.pop_front()

	func refill_hopper():
		var total_weight = 0
		for weight in joke_distribution.values():
			total_weight += weight

		var random_choice = randi() % total_weight
		var cumulative_weight = 0
		for joke_type in joke_distribution.keys():
			cumulative_weight += joke_distribution[joke_type]
			if random_choice < cumulative_weight:
				joke_queue.push_back(joke_type)
				break


var sample_distribution = {
	JokeTypes.DAD_JOKE: 30,
	JokeTypes.KNOCK_KNOCK: 25,
	JokeTypes.DARK_HUMOR: 5,
	JokeTypes.FART_JOKE: 20,
	JokeTypes.CAT_JOKE: 10,
	JokeTypes.DOG_JOKE: 10
}

# Example usage
var joke_hopper = JokeHopper.new(sample_distribution)


var playful_humor = SenseOfHumor.new(
	"Playful",
	"Loves light and fun jokes",
	sample_distribution,
	"res://icons/playful_icon.png"  # Path to the icon image
)


