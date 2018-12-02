extends KinematicBody
class_name EnemyShot

func aim(xform: Transform) -> void:
	global_transform = xform

func _physics_process(delta: float) -> void:
	move_and_collide( Transform(transform.basis) * Vector3(0,0,-1) * delta * 20 )
	
	if global_transform.origin.z < -100:
		queue_free()