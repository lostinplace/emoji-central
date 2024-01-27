extends Node

const sprite_height = 143;
const sprite_width = 131;
const sprite_size = Vector2(sprite_width, sprite_height)

var spritesheet = preload("res://Assets/spritesheet.png")

static func get_sprite_rect(column: int, row: int):
	var x = column * sprite_height
	var y = row * sprite_width
	var sprite_position = Vector2(x, y)
	var result = Rect2(sprite_position, sprite_size)
	
	return result
