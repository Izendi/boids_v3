extends CharacterBody2D

class_name Regular_Boid


var neighbor_boids: Array[Node2D] = []

@onready var area2D_influence_shape = $Area2D
@onready var area2D_influence_radius = $Area2D/CollisionShape2D
@onready var no_boids: int = 0
@onready var old_no_boids: int = 0

@export var SPEED: float = 120.0

@export var separation_weight: float = 1.5
@export var alignment_weight: float = 1.0
@export var cohesion_weight: float = 1.0

func wrap_position(pos: Vector2, rect: Rect2) -> Vector2:
	return Vector2(
		wrapf(pos.x, rect.position.x, rect.position.x + rect.size.x),
		wrapf(pos.y, rect.position.y, rect.position.y + rect.size.y)
	)

func calcSteeringVector(separation_weight_val: float, alignment_weight_val: float, cohesion_weight_val: float) -> Vector2:
	var steeringVec: Vector2 = Vector2(0.0, 0.0)
	
	# 1 - SEPARATION
	
	var separation_force_vec: Vector2 = Vector2(0.0, 0.0)
	
	for neighbor_boid in neighbor_boids:
		if neighbor_boid != self:
			var distance_vec : Vector2 = self.global_position - neighbor_boid.global_position
			var distance: float = distance_vec.length()
			
			# this real distance thing is a hack to work around pixels not being the same as one unit being equal to a meter, change it if you chagne to 3D
			var one_meter_to_pixels = 20.0
			var real_distance = distance / one_meter_to_pixels
			
			var force: Vector2 = (self.global_position - neighbor_boid.global_position) / (real_distance * real_distance)
			
			separation_force_vec = separation_force_vec + force
	
	# 2 - ALIGNMENT
	var avg_neighbor_boid_velocity = Vector2.ZERO
	
	var neighbor_count = 0
	
	for neighbor_boid in neighbor_boids:
		if neighbor_boid != self:
			avg_neighbor_boid_velocity += (neighbor_boid.velocity).normalized()
			neighbor_count += 1
		
	if neighbor_count != 0:
		avg_neighbor_boid_velocity = avg_neighbor_boid_velocity / neighbor_count
	
	var alignment_vec: Vector2 = Vector2(0.0, 0.0)
	
	alignment_vec = ((avg_neighbor_boid_velocity.normalized()) - ((self.velocity).normalized())).normalized()
	
	# 3 - COHESION
	var dir_to_center_of_neighbors_mass: Vector2 = Vector2(0.0, 0.0)
	var neighbors_center_of_mass: Vector2 = Vector2(0.0, 0.0)
	var neighbor_count_2: float = 0.0
	
	for neighbor_boid in neighbor_boids:
		if neighbor_boid != self:
			neighbors_center_of_mass += neighbor_boid.global_position
			neighbor_count_2 += 1.0
	
	if neighbor_count_2 != 0:
		neighbors_center_of_mass = neighbors_center_of_mass / neighbor_count_2
	
	var cohesion_vector = (neighbors_center_of_mass - self.global_position).normalized()
	
	steeringVec = separation_force_vec * separation_weight_val + alignment_vec * alignment_weight_val + cohesion_vector * cohesion_weight_val
	
	return steeringVec

func _ready():
	velocity = Vector2(60.0, 0.0)

func _physics_process(delta):
	area2D_influence_radius.shape.radius = GLOBAL.BOID_INFLUENCE_RADIUS
	neighbor_boids = area2D_influence_shape.get_overlapping_bodies()
	
	old_no_boids = no_boids
	no_boids = 0
	
	for boid in neighbor_boids:
		if boid != self:
			no_boids += 1
	
	if no_boids != old_no_boids:
		var myStr: String = "Boids nearby = " + str(no_boids)
		print(myStr)
	
	# ------------------
	
	#velocity = velocity + Vector2(0, 9.8) * delta #move and slide with multiply this by the delta for me.
	#velocity = velocity.limit_length(120)
	
	var steeringVector: Vector2 = calcSteeringVector(GLOBAL.SEPARATION_WEIGHT, GLOBAL.ALIGNMENT_WEIGHT, GLOBAL.COHESION_WEIGHT) 
	velocity = velocity + steeringVector
	velocity = (velocity.normalized()) * GLOBAL.BOID_SPEED
	
	rotation = velocity.angle()
	#velocity = Vector2(50.0, 50.0)
	
	move_and_slide()
	global_position = wrap_position(global_position, get_viewport_rect())
