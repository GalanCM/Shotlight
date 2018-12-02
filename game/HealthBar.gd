extends ProgressBar

func _ready() -> void:
	var player : PlayerNode = JamKit.get_unique_node("Player")
	
	if is_instance_valid(player):
		player.connect("took_damage", self, "adjust")

func adjust(health):
	self.value = health