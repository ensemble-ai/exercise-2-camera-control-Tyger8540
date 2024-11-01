class_name LerpLead
extends CameraControllerBase

@export var lead_speed: float
@export var catchup_delay_duration: float
@export var catchup_speed: float
@export var leash_distance: float

var catchup_ready:= false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position
	$CatchupTimer.wait_time = catchup_delay_duration


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	if position.distance_to(target.position) > leash_distance + dist_above_target:
		var total_dist = position.distance_to(target.position) - dist_above_target
		var x_dist = target.position.x - position.x
		var z_dist = target.position.z - position.z
		# MOVE THE POSITION PROPORTIONAL TO THE LEASH DISTANCE AND X & Z DISTANCES OR SOMETHING
		position.x += (x_dist / total_dist) * (total_dist - leash_distance) * delta
		position.z += (z_dist / total_dist) * (total_dist - leash_distance) * delta
	elif !target.velocity.is_zero_approx():
		if !$CatchupTimer.is_stopped():
			$CatchupTimer.stop()
		var dir_x = clampf(target.velocity.x, -1.0, 1.0)
		var dir_z = clampf(target.velocity.z, -1.0, 1.0)
		if target.velocity.x + target.velocity.z > 2 * target.BASE_SPEED:
			global_position += target.velocity * delta
		else:
			position = position.move_toward(Vector3(target.position.x + dir_x * leash_distance, position.y, target.position.z + dir_z * leash_distance), lead_speed * delta)
	elif target.velocity.is_zero_approx() and (position.x != target.position.x or position.z != target.position.z):
		if catchup_ready:
			position = position.move_toward(Vector3(target.position.x, position.y, target.position.z), catchup_speed * delta)
		elif !catchup_ready and $CatchupTimer.is_stopped():
			$CatchupTimer.start()
	elif position.x == target.position.x and position.z == target.position.z and catchup_ready:
		catchup_ready = false
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -2.5
	var right:float = 2.5
	var top:float = -2.5
	var bottom:float = 2.5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# horizontal crosshair line
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	
	# vertical crosshair line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()


func _on_catchup_timer_timeout() -> void:
	catchup_ready = true
