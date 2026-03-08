extends Node2D

@export var total_coins := 5
@export var level_time := 75.0

var coins_collected := 0
var timer_left := 0.0
var has_key := false
var door_unlocked := false
var game_over := false

@onready var player = $Player
@onready var score_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/ScoreLabel
@onready var health_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/HealthLabel
@onready var timer_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/TimerLabel
@onready var inventory_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/InventoryLabel
@onready var status_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/StatusLabel
@onready var objective_label: Label = $CanvasLayer/HUD/Panel/VBoxContainer/ObjectiveLabel
@onready var message_label: Label = $CanvasLayer/CenterMessage

func _ready() -> void:
	add_to_group("world")
	timer_left = level_time
	player.health_changed.connect(_on_player_health_changed)
	update_hud()
	show_message("Collect all coins, grab the key, unlock the door, and escape.", 2.4)

func _process(delta: float) -> void:
	if game_over:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()
		return

	timer_left = max(0.0, timer_left - delta)
	update_hud()
	if timer_left <= 0.0:
		lose_game("Time ran out. Press R to restart.")

func on_collectible_picked(item_type: String, amount: int, node: Node) -> void:
	if game_over:
		return
	match item_type:
		"coin":
			coins_collected += amount
			show_message("Coin collected", 0.8)
		"key":
			has_key = true
			player.set_has_key(true)
			show_message("You picked up the key", 1.0)
		"medkit":
			player.heal(25)
			show_message("Health restored", 0.8)
	node.queue_free()
	update_hud()

func on_door_unlocked() -> void:
	door_unlocked = true
	update_hud()
	show_message("Door unlocked. Head to the exit.", 1.2)

func try_finish_level() -> void:
	if game_over:
		return
	if coins_collected < total_coins:
		show_hint("You still need %d coin(s)." % (total_coins - coins_collected))
		return
	if not has_key:
		show_hint("Find the key before leaving.")
		return
	if not door_unlocked:
		show_hint("Unlock the door first.")
		return
	win_game()

func _on_player_health_changed(current: int, _max_value: int) -> void:
	health_label.text = "Health: %d" % current
	if current <= 0 and not game_over:
		lose_game("You were defeated. Press R to restart.")

func update_hud() -> void:
	score_label.text = "Coins: %d / %d" % [coins_collected, total_coins]
	timer_label.text = "Time: %d" % int(ceil(timer_left))
	inventory_label.text = "Key: %s | Door: %s" % ["Yes" if has_key else "No", "Open" if door_unlocked else "Locked"]
	if not game_over:
		objective_label.text = "Objective: Escape the temple"

func show_hint(text: String) -> void:
	if game_over:
		return
	status_label.text = text

func clear_hint() -> void:
	if not game_over and not status_label.text.begins_with("You"):
		status_label.text = ""

func show_message(text: String, duration := 1.2) -> void:
	message_label.text = text
	message_label.visible = true
	var tween := create_tween()
	tween.tween_interval(duration)
	tween.tween_callback(func():
		if not game_over:
			message_label.visible = false
	)

func lose_game(text: String) -> void:
	game_over = true
	player.can_move = false
	status_label.text = text
	objective_label.text = "Objective failed"
	message_label.text = "MISSION FAILED"
	message_label.visible = true

func win_game() -> void:
	game_over = true
	player.can_move = false
	status_label.text = "You escaped successfully. Press R to play again."
	objective_label.text = "Objective complete"
	message_label.text = "TEMPLE CLEARED"
	message_label.visible = true
