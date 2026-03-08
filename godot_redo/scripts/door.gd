extends StaticBody2D

@export var requires_key := true
var player_near := false
var is_open := false

func _ready() -> void:
	$InteractArea.body_entered.connect(_on_body_entered)
	$InteractArea.body_exited.connect(_on_body_exited)
	var player := get_tree().get_first_node_in_group("player")
	if player:
		player.interacted.connect(_on_player_interacted)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = true
		var world := get_tree().get_first_node_in_group("world")
		if world and world.has_method("show_hint"):
			world.show_hint("Press E to unlock the door")

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = false
		var world := get_tree().get_first_node_in_group("world")
		if world and world.has_method("clear_hint"):
			world.clear_hint()

func _on_player_interacted() -> void:
	if is_open or not player_near:
		return
	var player := get_tree().get_first_node_in_group("player")
	var world := get_tree().get_first_node_in_group("world")
	if requires_key and player and not player.has_key:
		if world and world.has_method("show_hint"):
			world.show_hint("The door is locked. Find the key.")
		return
	is_open = true
	$CollisionShape2D.set_deferred("disabled", true)
	$DoorVisual.color = Color(0.3, 0.9, 0.5, 0.35)
	if world and world.has_method("on_door_unlocked"):
		world.on_door_unlocked()
