extends CharacterBody2D


@export var SPEED : float = 10
var direction : float = 2
var viewlength : float = 100
@export var animation_tree : AnimationTree
var playback : AnimationNodeStateMachinePlayback
var woken : bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	playback = animation_tree["parameters/playback"]
	$RayCastTargetRight.target_position.x = viewlength
	$RayCastTargetLeft.target_position.x = -viewlength
	
	if viewlength > 100 and not woken: 
		playback.travel("wake")
	
	if woken: 
		velocity.x = direction * SPEED
	if $RayCastTargetRight.is_colliding():
		if $RayCastTargetRight.get_collider() is CharacterBody2D:
			direction = 3
			$Marker2D.scale.x = -1
			viewlength = 300
	
	else:
		direction = 0
		
	if $RayCastLeft.is_colliding():
		if $RayCastTargetLeft.get_collider() is CharacterBody2D: 
			direction = -3
			$Marker2D.scale.x = 1
			viewlength = 300
	else: 
		direction = 0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not $RayCastRight.is_colliding():
		direction = -2
		$Marker2D.scale.x = 1
	if not $RayCastLeft.is_colliding():
		direction = 2
		$Marker2D.scale.x = -1

	move_and_slide()


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "wake": 
		woken = true
	
