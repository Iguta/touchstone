extends CharacterBody2D

@export var point_a := Vector2.ZERO
@export var point_b := Vector2(240, 0)
@export var speed := 110.0
@export var damage := 12

var target := Vector2.ZERO

func _ready() -> void:
	target = point_b
	$Hitbox.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(target)
	velocity = direction * speed
	move_and_slide()
	if global_position.distance_to(target) < 8.0:
		target = point_a if target == point_b else point_b
	if velocity.length() > 1.0:
		rotation = velocity.angle()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
