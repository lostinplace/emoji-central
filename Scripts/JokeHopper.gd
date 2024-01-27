
class JokeHopper:
	var joke_queue = []
	var joke_distribution: Dictionary
	var hopper_size

	func _init(_joke_distribution: Dictionary, _size: int):
		joke_distribution = _joke_distribution
		hopper_size = _size
		refill_hopper()

	func dequeue_joke() -> int:
		var result = joke_queue.pop_front()
		if joke_queue.size() < hopper_size:
			refill_hopper()
		return result

	func refill_hopper():
		while joke_queue.size() < hopper_size:
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
