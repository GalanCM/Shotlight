extends Spatial

func _ready() -> void:
	($Particles as Particles).emitting = true

	yield(get_tree().create_timer(5), "timeout")
	queue_free()
