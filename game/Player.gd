extends KinematicBody
class_name PlayerNode

var current_shotlight : ShotLight

func _ready() -> void:
	JamKit.set_unique_node("Player", self)
	spawn_shotlight()

func _physics_process(delta: float) -> void:
	var bounds : Vector3 = (JamKit.get_unique_node("GameWorld") as GameWorld ).bounds
	
	translation.x = clamp(translation.x, -bounds.x, bounds.x)
	translation.y = clamp(translation.y, -bounds.y, bounds.y)
	
	var mx := Input.get_action_strength("PlayerLeft") - Input.get_action_strength("PlayerRight") 
	var my := Input.get_action_strength("PlayerUp") - Input.get_action_strength("PlayerDown")
	
	move_and_slide( Vector3(mx, my, 0) * 20 )
	
func spawn_shotlight() -> void:
	current_shotlight = preload("res://ShotLight.tscn").instance() as KinematicBody
	current_shotlight.translation.z = 3
	
	add_child( current_shotlight )
	
func absorb_lightbulb() -> void:
	current_shotlight.increase_glow(0.5)