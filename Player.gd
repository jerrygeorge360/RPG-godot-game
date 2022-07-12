extends KinematicBody2D
export var MAX_SPEED=400
export var ACCELERATION=10
export var FRICTION=400
var velocity=Vector2.ZERO

var animation_player=null
var animation_tree=null
var animation_state=null

func _ready():
	animation_player=get_node("AnimationPlayer")
	animation_tree=get_node("AnimationTree")
	animation_state=animation_tree.get("parameters/playback")
	print(get_viewport())
	
	

func _physics_process(delta):
	var input_vector=Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vector.y=Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vector=input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position",input_vector)
		animation_tree.set("parameters/Run/blend_position",input_vector)
		animation_state.travel("Run")
	

		velocity=velocity.move_toward(MAX_SPEED*input_vector,ACCELERATION*delta)
	else:
		animation_state.travel("Idle")
		velocity= velocity.move_toward(Vector2.ZERO,FRICTION * delta)
	return move_and_slide(velocity)
