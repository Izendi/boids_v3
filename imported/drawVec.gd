extends Node2D

var origin: Vector2 = Vector2.ZERO
var end: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.UP

var drawnLineVec: Vector2 = Vector2(0.0, 0.0)

var mouse_world_pos := Vector2.ZERO

var steeringDirection := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getDrawnLineVec() -> Vector2:
	return drawnLineVec

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("lmb"):
		mouse_world_pos = get_global_mouse_position()
	
	queue_redraw()

#remember that draw convers coordinates from local space to global space, so if you pass in global space coordinates you will get weird results
func _draw():
	origin = Vector2.ZERO
	direction = to_local(mouse_world_pos)
	steeringDirection = (mouse_world_pos - get_parent().global_position).normalized()
	#direction = direction.normalized()
	end = origin + direction
	
	drawnLineVec = end
	
	draw_line(origin, end, Color.RED, 4.0) #Mouse Position Vector
	
	##Draw forward Vector:
	origin = Vector2.ZERO
	#direction = get_parent().forward_vector
	#direction = direction * 200
	end = to_local(get_parent().global_position + get_parent().velocity)
	
	
	draw_line(origin, end, Color.HOT_PINK, 4.0)
