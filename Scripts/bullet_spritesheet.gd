extends Node

const sprite_height = 64;
const sprite_width = 64;
const sprite_size = Vector2(sprite_width, sprite_height)

var categories = [
	"Hands",
	"Baked Goods",
	"Sports",
	"Plants",
	"Traffic",
	"Water",
	"Music",
	"Animals"
]

static func get_sprite_rect(joketype: int):
	
	var row:int  = floor(joketype/4)
	var col:int = joketype % 4
	
	var x = col * sprite_height
	var y = row * sprite_width
	var sprite_position = Vector2(x, y)
	var result = Rect2(sprite_position, sprite_size)
	
	return result
