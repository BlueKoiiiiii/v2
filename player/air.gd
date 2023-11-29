extends State
@export var fall_state : State

func state_process(delta):
	if (character.velocity.y > 0):
		next_state = fall_state
		playback.travel("falltransition")
