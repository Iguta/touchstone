extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		var world := get_tree().get_first_node_in_group("world")
		if world and world.has_method("try_finish_level"):
			world.try_finish_level()
