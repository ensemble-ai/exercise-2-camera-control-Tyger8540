class_name SpeedupPushZone
extends CameraControllerBase


@export var push_ratio: float
@export var pushbox_top_left: Vector2
@export var pushbox_bottom_right: Vector2
@export var speedup_zone_top_left: Vector2
@export var speedup_zone_bottom_right: Vector2

var pushbox_box_height: float
var pushbox_box_width: float
var speedup_zone_box_height: float
var speedup_zone_box_width: float

func _ready() -> void:
	super()
	position = target.position
	pushbox_box_height = pushbox_bottom_right.y - pushbox_top_left.y
	pushbox_box_width = pushbox_bottom_right.x - pushbox_top_left.x
	speedup_zone_box_height = speedup_zone_bottom_right.y - speedup_zone_top_left.y
	speedup_zone_box_width = speedup_zone_bottom_right.x - speedup_zone_top_left.x
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks & speedup checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - pushbox_box_width / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	elif (tpos.x + target.WIDTH / 2.0 <= cpos.x - speedup_zone_box_width / 2.0) and target.velocity.x < 0.0:
		global_position.x += target.velocity.x * push_ratio * delta
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_box_width / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	elif (tpos.x - target.WIDTH / 2.0 >= cpos.x + speedup_zone_box_width / 2.0) and target.velocity.x > 0.0:
		global_position.x += target.velocity.x * push_ratio * delta
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_box_height / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	elif (tpos.z + target.WIDTH / 2.0 <= cpos.z - speedup_zone_box_height / 2.0) and target.velocity.z < 0.0:
		global_position.z += target.velocity.z * push_ratio * delta
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_box_height / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
	elif (tpos.z - target.WIDTH / 2.0 >= cpos.z + speedup_zone_box_height / 2.0) and target.velocity.z > 0.0:
		global_position.z += target.velocity.z * push_ratio * delta
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var pushbox_left:float = -pushbox_box_width / 2
	var pushbox_right:float = pushbox_box_width / 2
	var pushbox_top:float = -pushbox_box_height / 2
	var pushbox_bottom:float = pushbox_box_height / 2
	
	var speedup_zone_left:float = -speedup_zone_box_width / 2
	var speedup_zone_right:float = speedup_zone_box_width / 2
	var speedup_zone_top:float = -speedup_zone_box_height / 2
	var speedup_zone_bottom:float = speedup_zone_box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_top))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_top))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_left, 0, speedup_zone_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_right, 0, speedup_zone_top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
