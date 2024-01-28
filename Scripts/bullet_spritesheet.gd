extends Node

const sprite_height = 64;
const sprite_width = 64;
const sprite_size = Vector2(sprite_width, sprite_height)

static var categories ={ 
	"Hands": {"category": "Hands", "y-offset":0 },
	"Baked Goods": {"category": "Baked Goods", "y-offset":1 },
	"Sports": {"category": "Sports", "y-offset":2 },
	"Traffic": {"category": "Traffic", "y-offset":4 },
	"Music": {"category": "Music", "y-offset":6 },
	"Animals": {"category": "Animals", "y-offset":7 }
}

static var unused_categories = { 
	"Hands": {"category": "Hands", "y-offset":0 },
	"Baked Goods": {"category": "Baked Goods", "y-offset":1 },
	"Sports": {"category": "Sports", "y-offset":2 },
	"Traffic": {"category": "Traffic", "y-offset":4 },
	"Music": {"category": "Music", "y-offset":6 },
	"Animals": {"category": "Animals", "y-offset":7 }
}

static func get_random_category_names():
	var cat_names = categories.keys()
	cat_names.shuffle()
	return cat_names
	

static func get_unused_category() -> Dictionary:
	var keys = []
	for key in unused_categories:
		keys.append(key)
	var chosenKey = keys[randi() % keys.size()]
	var result = unused_categories[chosenKey]
	unused_categories.erase(chosenKey)
	return result
	

static func get_random_category() -> Dictionary:
	var keys = []
	for key in categories:
		keys.append(key)
	var result = categories[keys[randi() % keys.size()]]
	return result
	
static func get_category_rect(category_name: String) -> Rect2:
	var category = categories[category_name]
	var offset_y = category["y-offset"] * sprite_height
	var result = Rect2(Vector2(0, offset_y), sprite_size)
	return result

static func get_rect_for_joke(joke_number:int, category_name: String) -> Rect2:
	var category = categories[category_name]
	var offset_y = category["y-offset"] * sprite_height
	var offset_x = joke_number * sprite_width
	var result = Rect2(Vector2(offset_x, offset_y), sprite_size)
	return result
	
static func get_category_not_in_category(category: Dictionary):
	var category_copy = []
	for key in categories:
		if key != category["category"]:
			category_copy.append(categories[key])
		
	var result = category_copy[randi() % category_copy.size()]
	return result
