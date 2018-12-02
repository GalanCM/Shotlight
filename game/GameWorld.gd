extends WorldEnvironment
class_name GameWorld

var bounds := Vector3(28, 13, 150)

func _ready() -> void:
	JamKit.set_unique_node("GameWorld", self)