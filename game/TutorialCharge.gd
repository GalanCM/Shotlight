extends Tutorial

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ShotFire"):
		emit_signal("next_tutorial")
		
		($AnimationPlayer as AnimationPlayer).play("Fade")
	
		yield($AnimationPlayer, "animation_finished")
		emit_signal("next_tutorial")