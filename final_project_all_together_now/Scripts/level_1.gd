extends Node2D

var enemy1 = preload("res://Scenes/Enemy1.tscn")
var enemy2 = preload("res://Scenes/Enemy2.tscn")

# Spawn bounds
@export var min_x = 150.0
@export var max_x = 1000.0
@export var min_y = 100.0
@export var max_y = 550.0

var total_enemies = 10
var enemies_spawned = 0
var spawn_interval = 15.0 / 10  # 15 seconds / 10 enemies = 1.5s between each
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

	# Alternate between enemy1 and enemy2
	var scene = enemy1 if enemies_spawned % 2 == 0 else enemy2
	spawn_enemy(scene)
	enemies_spawned += 1
	enemies_remaining += 1

func spawn_enemy(scene) -> void:
	var enemy = scene.instantiate()
	# Randomly pick a side to spawn from (left or right)
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
	print("Wave complete! Next level in 5 seconds...")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
