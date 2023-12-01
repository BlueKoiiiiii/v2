extends AnimatedSprite2D
@export var slashbox : Marker2D
@export var anim : AnimationPlayer
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	anim.play("slash")
	

