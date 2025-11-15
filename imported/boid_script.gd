class_name main_boid
extends CharacterBody2D

@onready var child_VectorVisualizer_ref := $VectorVisualizer

@onready var lmb_line: Vector2 = child_VectorVisualizer_ref.end

@export var speed: float = 100
@export var steeringSpeed: float = 100
@export var rotationSpeed: float = 100

var forward_vector: Vector2 = Vector2.UP
var rotationDeg: float = 0
var steering_force: Vector2 = Vector2.ZERO

func wrap_position(pos: Vector2, rect: Rect2) -> Vector2:
	return Vector2(
		wrapf(pos.x, rect.position.x, rect.position.x + rect.size.x),
		wrapf(pos.y, rect.position.y, rect.position.y + rect.size.y)
	)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("lmb"):
		var steeringDirWithSpeed: Vector2 = child_VectorVisualizer_ref.steeringDirection * steeringSpeed
		steering_force = (steeringDirWithSpeed - velocity).limit_length(speed)
		velocity = velocity + steering_force * delta
		velocity = velocity.limit_length(speed)
		
	velocity = velocity.limit_length(speed)
	
	
	if (child_VectorVisualizer_ref.getDrawnLineVec()).length() > 0.01:
		rotation = (child_VectorVisualizer_ref.getDrawnLineVec()).angle() + deg_to_rad(90)
	
	move_and_slide() #this applied the "velocity" variable to the CharacterBody2D
	global_position = wrap_position(global_position, get_viewport_rect())
