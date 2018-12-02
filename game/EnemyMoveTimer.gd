extends Timer

func _ready() -> void:
	connect("timeout", get_parent(), "move")