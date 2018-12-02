extends Spatial

var has_spawned := false
var count : int = 0
var enemies := []
var launch_locations := []


func _ready() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	for i in range(min(4 + count / 4, 15) ):
		var enemy : Enemy = preload("res://Enemy.tscn").instance()
		add_child( enemy )
		
		var bounds := (JamKit.get_unique_node("GameWorld") as GameWorld).bounds
		var fixed_axis : int = randi() % 2 == 0
		var directions = Vector2(1 if randi() % 2 else -1, 1 if randi() % 2 else -1)
		enemy.transform.origin = Vector3(
			(bounds.x+2 if fixed_axis == 0 else rand_range(-bounds.x, bounds.x)) * directions.x,
			(bounds.y+2 if fixed_axis == 1 else rand_range(-bounds.y, bounds.y)) * directions.y,
			900
		)
		
		rand_seed(OS.get_unix_time())
		
		launch_locations.push_back( rand_range(20, 500) )
		enemies.push_back(enemy)
		
	launch_locations.sort()
	launch_locations.invert()

func _process(delta: float) -> void:
	translate( Vector3(0,0,-200) * delta)

	if !has_spawned and transform.origin.z <= 0:
		var spawn : Spatial = preload("res://Tunnel.tscn").instance()
		spawn.global_transform.origin.z = 1050
		spawn.count += 1
		JamKit.get_unique_node("GameWorld").add_child( spawn )
		
		has_spawned = true

func _physics_process(delta: float) -> void:
	if !launch_locations.empty() and !enemies.empty() and (!is_instance_valid(enemies[0]) or launch_locations[0] >= enemies[0].global_transform.origin.z):
		var launcher = (enemies.pop_front() as Enemy)
		launch_locations.remove(0)
		
		if is_instance_valid(launcher):
			launcher.launch()