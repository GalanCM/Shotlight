extends Camera

func _process(delta: float) -> void:
	var player : PlayerNode = JamKit.get_unique_node("Player")
	
	if player:
		var direction := player.global_transform.origin - global_transform.origin
		var distance := direction.length()
		direction = direction.normalized()
		direction.z = 0
		
		print(direction)
		global_translate(direction * delta * distance * 2)
