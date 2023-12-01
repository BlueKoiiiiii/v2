extends CharacterBody2D


@export var SPEED : float = 10
var direction : float = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	
	if $RayCastTargetRight.is_colliding():
		if $RayCastTargetRight.get_collider() is CharacterBody2D:
			direction = 3
			$Marker2D.scale.x = -1
	
	else:
		direction = 0
	if $RayCastLeft.is_colliding():
		if $RayCastTargetLeft.get_collider() is CharacterBody2D: 
			direction = -3
			$Marker2D.scale.x = 1
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
	
	velocity.x = direction * SPEED
	
	
	move_and_slide()
