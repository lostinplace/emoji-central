extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#if has_meta("PlayerName"):
		#$Panel/Label.text = get_meta("PlayerName")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_queue_sprites(rects :Array[Rect2]):
	for i in rects.size():
		var name = "Panel/q{i}".format({"i":i})
		if is_instance_valid(get_node(name)):
			var node = get_node(name)
			if node == null:
				continue
			node.region_rect=rects[i]
		
