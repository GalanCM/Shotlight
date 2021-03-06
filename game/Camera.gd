extends Camera

func _process(delta: float) -> void:
	var player : PlayerNode = JamKit.get_unique_node("Player")
	
	if is_instance_valid(player):
		var direction := player.global_transform.origin - global_transform.origin
		var distance := direction.length()
		direction = direction.normalized()
		direction.z = 0
		
		global_translate(direction * delta * distance * 6)
