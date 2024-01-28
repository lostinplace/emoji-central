class Joke:
	var JokeNumber: int
	var Category: String

	func _init(_joke_number: int, _category: String):
		JokeNumber = _joke_number
		Category = _category

	static func get_random_joke_number() -> int:
		# get a random number between 1 and 9
		var result = randi() % 5 + 1
		return result

var bs = preload("res://Scripts/bullet_spritesheet.gd")

class JokeHopper:
	var joke_queue : Array = []
	var joke_distribution: Dictionary
	var hopper_size
	var my_category

	func _init(_category: String, _size: int):
		
		hopper_size = _size
		var bs = preload("res://Scripts/bullet_spritesheet.gd")
		
		self.my_category = bs.categories[_category]
		refill_hopper()

	func dequeue_joke():
		var result = joke_queue.pop_front()
		refill_hopper()
		return result

	func refill_hopper():
		var bs = preload("res://Scripts/bullet_spritesheet.gd")
		while joke_queue.size() < hopper_size:
			var joke_number = Joke.get_random_joke_number()
			var joke_cat = bs.get_category_not_in_category(my_category) 
			
			var joke = Joke.new(joke_number, joke_cat.category)
			joke_queue.append(joke)
	
	func get_sprite_rects() -> Array[Rect2]:
		var bs = preload("res://Scripts/bullet_spritesheet.gd")
		var result: Array[Rect2] = []
		for joke in joke_queue:
			var rect = bs.get_rect_for_joke(joke.JokeNumber, joke.Category)
			result.append(rect)
		return result
