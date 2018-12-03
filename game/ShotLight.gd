extends KinematicBody
class_name ShotLight

var fired := false

func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	($ChargePlayer as AudioStreamPlayer3D).play()
	while true:
		yield(get_tree().create_timer(rand_range(0.5, 2.5)), "timeout")
		if fired == true:
			break
		($Glow/FlashPlayer as AnimationPlayer).play("Flash1" if randi() % 2 == 0 else "Flash2")
		
func _process(delta: float) -> void:
	if Input.is_action_pressed("ShotFire"):
		increase_glow(delta * 0.5)
	
func _physics_process(delta: float) -> void:
	if fired:
		var collision := move_and_collide( Vector3(0,0,100*delta) )
		if collision and collision.collider.has_method("die"):
			collision.collider.die()
			($Glow/FlashPlayer as AnimationPlayer).play("Flash1")
			
		if global_transform.origin.z > 1500:
			queue_free()

func _input(event: InputEvent) -> void:
	if not fired and event.is_action_released("ShotFire"):
		var self_transform = global_transform
		get_parent().remove_child(self)
		JamKit.get_unique_node("GameWorld").add_child(self)
		global_transform = self_transform
		($ShotPlayer as AudioStreamPlayer3D).play()
		fired = true
		
		var player = JamKit.get_unique_node("Player")
		if is_instance_valid(player):
			player.spawn_shotlight()
			
func increase_glow(amount: float) -> void:
	($SpotLight as SpotLight).spot_range += amount * 40
	($CollisionShape as CollisionShape).scale += Vector3(1,1,1) * amount *0.2
	
	var glow = ($Glow as Sprite3D)
	glow.scale += Vector3(1,1,1) * amount * 0.2
	
	
	var core = ($Core as Sprite3D)
	core.scale += Vector3(1,1,1) * amount * 0.05
	core.scale.x = min(core.scale.x, 0.3)
	core.scale.y = min(core.scale.y, 0.3)
	core.scale.z = min(core.scale.z, 0.3)
	
	core.opacity = min (core.opacity + amount * 0.2, 1)
	
	var charge_player : AudioStreamPlayer3D = $ChargePlayer
	charge_player.unit_db = min( charge_player.unit_db + 10 * amount, 10)
	