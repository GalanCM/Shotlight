extends KinematicBody
class_name Enemy

func launch() -> void:
	var self_transform := global_transform
	get_parent().remove_child(self)
	JamKit.get_unique_node("GameWorld").add_child(self)
	global_transform = self_transform
	
	var direction := Vector2(-1 if global_transform.origin.x > 0 else 1, -1 if global_transform.origin.y > 0 else 1)
	var goal := Vector3( rand_range(5, 10) * direction.x, rand_range(5, 10) * direction.y, 0)
	var tween := Tween.new()
	tween.interpolate_property(self, "translation", global_transform.origin, global_transform.origin + goal, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	add_child(tween)
	tween.start()
	
	$MoveTimer.start()
	$ShotTimer.start()
	
	yield(tween, "tween_completed")
	tween.queue_free()

func _physics_process(delta: float) -> void:
	var player : PlayerNode = JamKit.get_unique_node("Player")
	
	if player:
		look_at(player.global_transform.origin, Vector3(0,1,0))

func move() -> void:
	var bounds : Vector2 = (JamKit.get_unique_node("GameWorld") as GameWorld ).bounds
	
	var goal := Vector3(rand_range(5, 10), rand_range(5, 10), rand_range(20, 200))
	goal *= Vector3(1 if randi() % 2 else -1, 1 if randi() % 2 else -1, 1 if randi() % 2 else -1)
	if goal.x + global_transform.origin.x > bounds.x or goal.x + global_transform.origin.x < bounds.x:
		goal.x = -goal.x
	if goal.y + global_transform.origin.y > bounds.y or goal.y + global_transform.origin.y < bounds.y:
		goal.y = -goal.y
	if goal.z + global_transform.origin.z > 500 or goal.z + global_transform.origin.z < 20:
		goal.z = -goal.z
	
	var tween := Tween.new()
	tween.interpolate_property(self, "translation", global_transform.origin, global_transform.origin + goal, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()
	
	yield(tween, "tween_completed")
	tween.queue_free()
	
func shoot() -> void:
	var shot : EnemyShot = preload( "res://EnemyShot.tscn").instance()
	shot.aim(global_transform)
	JamKit.get_unique_node("GameWorld").add_child(shot)
	
	
func die() -> void:
	queue_free()
	
	var lightbulb := preload("res://LightBulb.tscn").instance() as KinematicBody
	lightbulb.global_transform = global_transform
	JamKit.get_unique_node("GameWorld").add_child( lightbulb )