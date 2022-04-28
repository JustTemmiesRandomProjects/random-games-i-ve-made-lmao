extends RayCast2D

var is_casting := false setget set_is_casting
export var orangeLaser = 1
export var blueLaser = 0

onready var Line2D = $Line2D

func _ready() -> void:
	set_physics_process(false)
	Line2D.points[1] = Vector2.ZERO
	#self.is_casting = true

func _process(delta):
	if orangeLaser == 1 and GameManager.orangeL == 1:
		fire_laser()
	elif blueLaser == 1 and GameManager.blueL == 1:
		fire_laser()
	else:
		if self.is_casting == true:
			self.is_casting = false
			#print("oh wait")
	
	#if $StaticBody2D.is_colliding():
#		print("woah")
		#Events.emit_signal("damaged", laser_beam.get_collider(), damage_per_second * delta, shooter)

#func _unhandled_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		self.is_casting = event.pressed


func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	
	$CollisionParticles2D.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		#$Line2D/Hitbox/CollisionShape2D.shape.a = to_local(get_collision_point())
		$CollisionParticles2D.global_rotation = get_collision_normal().angle()
		$CollisionParticles2D.position = cast_point

	Line2D.points[1] = cast_point
	$Line2D/Hitbox/CollisionShape2D.shape.a = cast_point
	$BeamParticles2D.position = cast_point * 0.5
	$BeamParticles2D.process_material.emission_box_extents.x = cast_point.length() * 0.5

func fire_laser():
	if self.is_casting == false:
			self.is_casting = true
			#print("fire!")


func set_is_casting(cast: bool) -> void:
	is_casting = cast

	$BeamParticles2D.emitting = is_casting
	$Particles2D.emitting = is_casting
	if is_casting:
		appear()

	else:
		$CollisionParticles2D.emitting = false
		disappear()
	set_physics_process(is_casting)


func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property(Line2D, "width", 0, 10.0, 0.2)
	$Line2D/Hitbox/CollisionShape2D.disabled = false
	$Tween.start()

func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property(Line2D, "width", 10.0, 0, 0.1)
	$Line2D/Hitbox/CollisionShape2D.disabled = true
	$Tween.start()
