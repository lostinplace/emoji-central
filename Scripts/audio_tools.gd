extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# This method plays an audio stream for a specific duration from a given offset
static func play_audio_for_duration(
	scene_tree: SceneTree, 
	audio_player: AudioStreamPlayer2D, 
	offset_ms: int, 
	duration_ms: int
	):
	# Assuming 'audio_player' is the name of your AudioStreamPlayer node

	# Load the stream and set the start offset
	#var sp = audio_player.play()
	#sp.seek(offset_ms * 0.001) # Convert ms to seconds

	# Start playing the audio
	var offset_s = offset_ms * 1000
	
	audio_player.play(offset_s)

	# Set a timer to stop playback after the duration
	var duration_s = duration_ms * 1000
	await scene_tree.create_timer(duration_s).timeout
	audio_player.stop()

	# Example usage

