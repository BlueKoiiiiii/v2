extends State
@export var animation_tree : AnimationTree
@export var air_state : State
@export var attack_state : State
@export var fall_state : State
@onready var dashtimer : Timer = $dashtimer
@export var dashattack_state : State
var runcondition : bool = false
var dashing : bool = false

func state_process(delta):
		update_animation()
		if !character.is_on_floor():
			next_state = fall_state
			playback.travel("falltransition")
		if character.velocity.x > 100 or character.velocity.x < -100: 
			playback.travel("run")
		else:
			playback.travel("Move")
		print(character.speed)
			
			

#	dashing = false
#	runcondition = false
#	playback.travel("Move")
func on_enter():
	dashing = false
	runcondition = false
#	character.speed = 70
	
func update_animation():
	var direction = Input.get_vector("left", "right", "up", "down")
	animation_tree.set("parameters/Move/blend_position", direction.x)

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		next_state = air_state
		character.velocity.y = -200
	if(event.is_action_pressed("attack") and not dashing):
		next_state = attack_state
		playback.travel("slash")
		var mouseposition = get_viewport().get_mouse_position()
		if mouseposition.x > 960: 
			character.marker.scale.x = 1
		else: 
			character.marker.scale.x = -1
	if(event.is_action_pressed("attack") and dashing):
		next_state = dashattack_state
		playback.travel("dashattack")
		var mouseposition = get_viewport().get_mouse_position()
		if mouseposition.x > 960: 
			character.marker.scale.x = 1
		else: 
			character.marker.scale.x = -1


	if(event.is_action_pressed("right") and not runcondition):
		dashtimer.start()
		runcondition = true
	elif(event.is_action_pressed("right") and runcondition):
		character.speed = 200
		dashing = true
#		playback.travel("run")
		
	if(event.is_action_pressed("left") and not runcondition):
		dashtimer.start()
		runcondition = true
	elif(event.is_action_pressed("left") and runcondition):
		character.speed = 200
		dashing = true
#		playback.travel("run")
	
	if(dashing):
		Signalbus.emit_signal("dashing", true)
		if(event.is_action_released("right") or event.is_action_released("left")):
			dashing = false
			character.speed = 70
			playback.travel("Move")
			Signalbus.emit_signal("dashing", false)


func _on_dashtimer_timeout():
	runcondition = false
