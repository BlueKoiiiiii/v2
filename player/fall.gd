extends State
@export var move_state : State
#@onready var timer : Timer = $movecooldown
var shot : bool = false
var running : bool = false

func on_enter():
	Signalbus.connect("dashing", runcheck)


func state_process(delta):
	if character.is_on_floor(): 
		next_state = move_state
		if not running:
			playback.travel("Move")
		else: 
			playback.travel("run")
		
func runcheck(dashing):
	if dashing: 
		running = true
	else: 
		running = false
