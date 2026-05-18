extends Node

var enemy1 = preload("res://Scenes/Enemy1.tscn")
var enemy2 = preload("res://Scenes/Enemy2.tscn")

@export var min_x = -240.0
@export var max_x = 710.0
@export var min_y = -190.0
@export var max_y = 210.0

var total_enemies = 25
var enemies_spawned = 0
var spawn_interval = 20.0 / 25
var enemies_remaining = 0

var spawn_timer: Timer

func _ready() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	if enemies_spawned >= total_enemies:
		spawn_timer.stop()
		return

	var scene = enemy1 if enemies_spawned % 2 == 0 else enemy2
	spawn_enemy(scene)
	enemies_spawned += 1
	enemies_remaining += 1

func spawn_enemy(scene) -> void:
	var enemy = scene.instantiate()
	var side = randi() % 2
	if side == 0:
		enemy.position = Vector2(min_x, randf_range(min_y, max_y))
	else:
		enemy.position = Vector2(max_x, randf_range(min_y, max_y))
	enemy.tree_exited.connect(_on_enemy_died)
	add_child(enemy)

func _on_enemy_died() -> void:
	enemies_remaining -= 1
	print("Enemy died, remaining: ", enemies_remaining)
	if enemies_spawned >= total_enemies and enemies_remaining <= 0:
		wave_complete()

func wave_complete() -> void:
	print("Wave 2 complete! Rolling The End in 5 seconds.")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/the end.tscn")
