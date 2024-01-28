extends Control

@onready var Main = get_tree().current_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	if has_meta("PlayerName"):
		$Panel/Label.text = get_meta("PlayerName")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_queue_sprites(rects :Array[Rect2]):
	for i in rects.size():
		var name = "Panel/q{i}".format({"i":i})
		if is_instance_valid(get_node(name)):
			var node = get_node(name)
			if node == null:
				continue
			node.region_rect=rects[i]
		
		#var name2 = "CharacterBody2D/Base/Panel/q{i}".format({"i":i})
		#if is_instance_valid(get_node(name2)):
			#var node = get_node(name2)
			#if node == null:
				#continue
			#node.region_rect=rects[i]
