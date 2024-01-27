extends GutTest


func test_hopper_functionality():
	var jt = load("res://Scripts/JokeTypes.gd")
	var JokeTypes = jt.JokeTypes
	
	var sample_distribution = {
		JokeTypes.DAD_JOKE: 30,
		JokeTypes.KNOCK_KNOCK: 25,
		JokeTypes.DARK_HUMOR: 5,
		JokeTypes.FART_JOKE: 20,
		JokeTypes.CAT_JOKE: 10,
		JokeTypes.DOG_JOKE: 10
	}
	
	var jh = load("res://Scripts/JokeHopper.gd")
	var JokeHopper = jh.JokeHopper

	# Example usage
	var test_joke_hopper = JokeHopper.new(sample_distribution, 5)
	
	var deqd = test_joke_hopper.dequeue_joke()
	
	var test_result = deqd != -1
	
	assert_true(test_result)
	

