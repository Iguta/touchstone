extends Area2D

@export_enum("coin", "key", "medkit") var item_type := "coin"
@export var amount := 1

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	var world := get_tree().get_first_node_in_group("world")
	if world and world.has_method("on_collectible_picked"):
		world.on_collectible_picked(item_type, amount, self)
