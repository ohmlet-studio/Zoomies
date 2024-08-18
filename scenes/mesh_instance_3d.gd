## GD SCRIPT ##
extends MeshInstance3D

var DOF_LENGTH = 250;
var COLLISION_MASK = 1;

func _physics_process(_delta):
	var end = global_position - global_transform.basis.z * DOF_LENGTH

	var rayParams = PhysicsRayQueryParameters3D.create(global_position, end, COLLISION_MASK)
	var ray = get_world_3d().direct_space_state.intersect_ray(rayParams)
	if !ray.is_empty():
		end = ray["position"]
	
	var sm = get_surface_override_material(0) as ShaderMaterial
	sm.set_shader_parameter("ray_position", end)
