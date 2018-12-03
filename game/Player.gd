extends KinematicBody
class_name PlayerNode

signal took_damage(health)

var current_shotlight : ShotLight

var health := 100

func _ready() -> void:
	JamKit.set_unique_node("Player", self)
	spawn_shotlight()

func _physics_process(delta: float) -> void:
	var game_world := (JamKit.get_unique_node("GameWorld") as GameWorld)
	if !is_instance_valid(game_world):
		return
	var bounds := game_world.bounds
	
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
	($CollectPlayer as AudioStreamPlayer3D).play()
	health += 5
	current_shotlight.increase_glow(0.5)
	
func take_hit() -> void:
	($HitPlayer as AudioStreamPlayer3D).play()
	health -= 50
	emit_signal("took_damage", health)
	
	if health <= 0:
		var explosion := preload("res://PlayerExplosion.tscn").instance() as Spatial
		explosion.global_transform = global_transform
		JamKit.get_unique_node("GameWorld").add_child( explosion )
		
		var game_over := preload("res://GameOver.tscn").instance() as Control
		JamKit.get_unique_node("GameWorld").add_child( game_over )
		
		queue_free()