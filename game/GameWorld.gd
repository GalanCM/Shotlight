extends WorldEnvironment
class_name GameWorld

var bounds := Vector2(30, 15)

func _ready() -> void:
	JamKit.set_unique_node("GameWorld", self)