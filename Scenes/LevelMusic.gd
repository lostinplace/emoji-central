extends AudioStreamPlayer2D

func _on_loop_sound(player):
	player.stream_paused = false
	player.play()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("finished", Callable(self,"_on_loop_sound").bind(self))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
