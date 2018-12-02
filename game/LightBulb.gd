extends KinematicBody
class_name LightBulb

func _physics_process(delta: float) -> void:
	var player : PlayerNode = JamKit.get_unique_node("Player")
	
	if player:
		var move_vector : Vector3 = (player.global_transform.origin - global_transform.origin).normalized() * 20
		var collision = move_and_collide(move_vector * delta * 10)
		
		if collision and collision.collider.has_method("absorb_lightbulb"):
			collision.collider.absorb_lightbulb()
			queue_free()