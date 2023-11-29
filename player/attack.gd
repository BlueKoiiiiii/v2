extends State
const slashPath = preload("res://player/slash.tscn")
@export var move_state : State
@export var slashposition : Marker2D
var slash = slashPath.instantiate()

func on_enter():
	slash = slashPath.instantiate()
	if get_viewport().get_mouse_position().x > 960:
		character.marker.scale.x = 1
		slash.flip_v = false
	else: 
		character.marker.scale.x = -1
		slash.flip_v = true
	add_child(slash)
	slash.position = slashposition.global_position
	slash.rotation = slashposition.global_rotation
	
func _on_animation_tree_animation_finished(anim_name):
	for child in get_children(): 
		if child is AnimatedSprite2D: 
			child.queue_free()
	if anim_name == "slash":
		next_state = move_state
#	slash.queue_free()


