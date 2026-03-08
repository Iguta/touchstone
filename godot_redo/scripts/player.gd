extends CharacterBody2D

signal health_changed(current: int, max_value: int)
signal interacted

@export var walk_speed: float = 220.0
@export var sprint_speed: float = 340.0
@export var max_health: int = 100

var health: int = max_health
var can_move := true
var has_key := false

@onready var sprite: Polygon2D = $Body

func _ready() -> void:
	add_to_group("player")
	health_changed.emit(health, max_health)

func _physics_process(_delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed := sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	velocity = input_dir * speed
	move_and_slide()

	if input_dir.length() > 0.1:
		rotation = input_dir.angle()

	if Input.is_action_just_pressed("interact"):
		interacted.emit()

func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	health_changed.emit(health, max_health)
	modulate = Color(1, 0.5, 0.5)
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.18)
	if health <= 0:
		can_move = false

func heal(amount: int) -> void:
	health = min(max_health, health + amount)
	health_changed.emit(health, max_health)

func set_has_key(value: bool) -> void:
	has_key = value
