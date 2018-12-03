extends KinematicBody
class_name EnemyShot

func aim(xform: Transform) -> void:
	global_transform = xform

func _physics_process(delta: float) -> void:
	var collision = move_and_collide( Transform(transform.basis) * Vector3(0,0,-1) * delta * 70 )
	
	if collision and collision.collider.has_method("take_hit"):
		collision.collider.take_hit()
		queue_free()
	
	if global_transform.origin.z < -100:
		queue_free()