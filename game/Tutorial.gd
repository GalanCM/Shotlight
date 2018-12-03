extends Label
class_name Tutorial

signal next_tutorial

func start_tutorial():
	set_process_input(false)
	($AnimationPlayer as AnimationPlayer).play("Intro")
	
	yield($AnimationPlayer, "animation_finished")
	set_process_input(true)

