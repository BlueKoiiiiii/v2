extends State
@export var move_state : State

func on_enter():
	can_move = true
	$Timer.start()

func state_process(delta):
	if $Timer.is_stopped(): 
		can_move = false
	print($Timer.time_left)
		
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "dashattack":
		next_state = move_state
		playback.travel("Move")
#		character.velocity.move_toward(Vector2.ZERO, 10)
