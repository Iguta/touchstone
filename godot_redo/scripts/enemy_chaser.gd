extends CharacterBody2D

@export var speed := 150.0
@export var chase_radius := 260.0
@export var damage := 18
@export var home_position := Vector2.ZERO

var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Node2D
	if home_position == Vector2.ZERO:
		home_position = global_position
	$Hitbox.body_entered.connect(_on_body_entered)

func _physics_process(_delta: float) -> void:
	if player == null:
		return
	var target := home_position
	if global_position.distance_to(player.global_position) <= chase_radius:
		target = player.global_position
	velocity = global_position.direction_to(target) * speed if global_position.distance_to(target) > 8.0 else Vector2.ZERO
	move_and_slide()
	if velocity.length() > 1.0:
		rotation = velocity.angle()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
