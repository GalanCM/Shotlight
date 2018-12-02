extends KinematicBody
class_name ShotLight

var fired := false

func _process(delta: float) -> void:
	increase_glow(delta)
	
func _physics_process(delta: float) -> void:
	if fired:
		var collision := move_and_collide( Vector3(0,0,50*delta) )
		if collision and collision.collider.has_method("die"):
			collision.collider.die()
			
		if global_transform.origin.z > 1500:
			queue_free()

func _input(event: InputEvent) -> void:
	if not fired and event.is_action_pressed("ShotFire"):
		var self_transform = global_transform
		get_parent().remove_child(self)
		JamKit.get_unique_node("GameWorld").add_child(self)
		global_transform = self_transform
		fired = true
		
		var player = JamKit.get_unique_node("Player")
		if player:
			player.spawn_shotlight()
			
func increase_glow(amount: float) -> void:
	($OmniLight as OmniLight).omni_range += amount * 8
	($CollisionShape as CollisionShape).scale += Vector3(1,1,1) * amount / 10
	($Glow as Sprite3D).scale += Vector3(1,1,1) * amount / 10