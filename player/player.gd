extends CharacterBody2D

class_name Player


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed : float = 70
@export var acceleration : float = 10
@export var friction : float = 20
@export var StateMachine : CharacterStateMachine 
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var marker : Marker2D = $Marker2D
@export var groundstate : State
var directionright : bool

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	$slashposition.look_at(get_global_mouse_position())
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if StateMachine.check_if_can_move(): 
		if direction:
			velocity.x = velocity.move_toward(speed * direction, acceleration).x
		else:
			velocity.x = velocity.move_toward(Vector2.ZERO, friction).x
		if direction.x > 0:
			marker.scale.x = 1
		if direction.x < 0: 
			marker.scale.x = -1
	else: 
#		speed = 0
		velocity.x = velocity.move_toward(Vector2.ZERO, friction).x
	


	move_and_slide()
