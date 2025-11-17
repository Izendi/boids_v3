extends Node2D

@onready var m_masterBoid: CharacterBody2D = %CharacterBody2D_masterBoid
@onready var m_mouse_world_pos: Vector2 = Vector2.ZERO

@onready var masterBoid_to_mouse_vec = Vector2.ZERO

@export var SPEED: float = 120

func _ready():
	pass
	

func _process(delta):
	pass
	

#Signals run before physics_process
func _physics_process(delta):
	#m_masterBoid.rotate(0.1)
	if Input.is_action_pressed("lmb"):
		m_mouse_world_pos = get_global_mouse_position()
		var masterBoid_global_pos: Vector2 = m_masterBoid.global_position
		
		masterBoid_to_mouse_vec = m_mouse_world_pos - masterBoid_global_pos
		
		m_masterBoid.rotation = masterBoid_to_mouse_vec.angle()
	
		queue_redraw()
	
	m_masterBoid.velocity = masterBoid_to_mouse_vec.normalized() * SPEED
	m_masterBoid.move_and_slide()

#remember that draw converts coordinates from local space to global space, so if you pass in global space coordinates you will get weird results
func _draw():
	var masterBoid_local_Pos: Vector2 = to_local(m_masterBoid.global_position)
	var mouse_local_pos: Vector2 = to_local(m_mouse_world_pos)
	
	draw_line(masterBoid_local_Pos, mouse_local_pos, Color.RED, 4.0)
	
