extends Tutorial

func _input(event: InputEvent) -> void:
	for action in ["PlayerUp", "PlayerDown", "PlayerLeft", "PlayerRight"]:
		if Input.is_action_just_pressed(action):
			
			($AnimationPlayer as AnimationPlayer).play("Fade")
	
			yield($AnimationPlayer, "animation_finished")
			emit_signal("next_tutorial")
