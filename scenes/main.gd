extends Node2D

@onready var m_masterBoid: CharacterBody2D = %CharacterBody2D_masterBoid

@onready var GUI_Panel: Panel = $CanvasLayer/Panel

@onready var m_mouse_world_pos: Vector2 = Vector2.ZERO

@onready var masterBoid_to_mouse_vec = Vector2.ZERO


func _ready():
	GUI_Panel.get_node("Label_influence_radius").text = "Influence Radius: " + str(GLOBAL.BOID_INFLUENCE_RADIUS)
	GUI_Panel.get_node("HSlider_boid_influence_radius").value = GLOBAL.BOID_INFLUENCE_RADIUS
	
	GUI_Panel.get_node("Label_Back_Angle_Blind_Spot").text = "Back Angle Blind Spot: " + str(GLOBAL.BOID_IGNORE_BEHIND_ANGLE)
	GUI_Panel.get_node("HSlider_Back_Angle_Blind_Spot").value = GLOBAL.BOID_IGNORE_BEHIND_ANGLE
	
	GUI_Panel.get_node("Label_Separation_Weight").text = "Separation Weight: " + str(GLOBAL.SEPARATION_WEIGHT)
	GUI_Panel.get_node("HSlider_Separation_Weight").value = GLOBAL.SEPARATION_WEIGHT
	
	GUI_Panel.get_node("Label_Alignment_Weight").text = "Alignment Weight: " + str(GLOBAL.ALIGNMENT_WEIGHT)
	GUI_Panel.get_node("HSlider_Alignment_Weight").value = GLOBAL.ALIGNMENT_WEIGHT
	
	GUI_Panel.get_node("Label_Cohesion_Weight").text = "Cohesion Weight: " + str(GLOBAL.COHESION_WEIGHT)
	GUI_Panel.get_node("HSlider_Cohesion_Weight").value = GLOBAL.COHESION_WEIGHT
	
	GUI_Panel.get_node("Label_Boid_Speed").text = "Boid Speed: " + str(GLOBAL.BOID_SPEED)
	GUI_Panel.get_node("HSlider_Boid_Speed").value = GLOBAL.BOID_SPEED
	

func _process(delta):
	pass
	

func wrap_position(pos: Vector2, rect: Rect2) -> Vector2:
	return Vector2(
		wrapf(pos.x, rect.position.x, rect.position.x + rect.size.x),
		wrapf(pos.y, rect.position.y, rect.position.y + rect.size.y)
	)

#Signals run before physics_process
func _physics_process(delta):
	#m_masterBoid.rotate(0.1)
	
	pass
	
	#var masterBoid_global_pos: Vector2 = m_masterBoid.global_position
	#masterBoid_to_mouse_vec = m_mouse_world_pos - masterBoid_global_pos
	#
	#if Input.is_action_pressed("lmb"):
		#var global_mouse_pos_check = get_global_mouse_position()
		#
		#if GUI_Panel.get_global_rect().has_point(global_mouse_pos_check) != true:
			#m_mouse_world_pos = get_global_mouse_position()
			#masterBoid_to_mouse_vec = m_mouse_world_pos - masterBoid_global_pos
		#
			#m_masterBoid.rotation = masterBoid_to_mouse_vec.angle()
		#
		#
	#
		##queue_redraw()
	#queue_redraw()
	#m_masterBoid.velocity = masterBoid_to_mouse_vec.normalized() * GLOBAL.BOID_SPEED
	#m_masterBoid.move_and_slide()
	#
	#m_masterBoid.global_position = wrap_position(m_masterBoid.global_position, get_viewport_rect())

#remember that draw converts coordinates from local space to global space, so if you pass in global space coordinates you will get weird results
func _draw():
	pass
	#var masterBoid_local_Pos: Vector2 = to_local(m_masterBoid.global_position)
	#var mouse_local_pos: Vector2 = to_local(m_mouse_world_pos)
	#
	#draw_line(masterBoid_local_Pos, mouse_local_pos, Color.RED, 4.0)
	


func _on_h_slider_boid_influence_radius_value_changed(value):
	GUI_Panel.get_node("Label_influence_radius").text = "Influence Radius: " + str(value)
	GLOBAL.BOID_INFLUENCE_RADIUS = value


func _on_h_slider_back_angle_blind_spot_value_changed(value):
	GUI_Panel.get_node("Label_Back_Angle_Blind_Spot").text = "Back Angle Blind Spot: " + str(value)
	GLOBAL.BOID_IGNORE_BEHIND_ANGLE = value


func _on_h_slider_separation_weight_value_changed(value):
	GUI_Panel.get_node("Label_Separation_Weight").text = "Separation Weight: " + str(value)
	GLOBAL.SEPARATION_WEIGHT = value


func _on_h_slider_cohesion_weight_value_changed(value):
	GUI_Panel.get_node("Label_Cohesion_Weight").text = "Cohesion Weight: " + str(value)
	GLOBAL.COHESION_WEIGHT = value


func _on_h_slider_alignment_weight_value_changed(value):
	GUI_Panel.get_node("Label_Alignment_Weight").text = "Alignment Weight: " + str(value)
	GLOBAL.ALIGNMENT_WEIGHT = value


func _on_h_slider_boid_speed_value_changed(value):
	GUI_Panel.get_node("Label_Boid_Speed").text = "Boid Speed: " + str(value)
	GLOBAL.BOID_SPEED = value
