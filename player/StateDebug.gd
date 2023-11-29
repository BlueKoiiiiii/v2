extends Label
@export var StateMachine : CharacterStateMachine


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State: " + StateMachine.current_state.name
