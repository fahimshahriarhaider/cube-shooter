extends Node3D

@export var enemy_scene: PackedScene

func _ready():
	$SpawnTimer.timeout.connect(spawn_enemy)

func spawn_enemy():
	if enemy_scene == null:
		return
	
	var enemy = enemy_scene.instantiate()
	var player = get_tree().get_first_node_in_group("player")
	
	var x = 0.0
	var z = 0.0
	
	# Try 10 times to find a spot that is far from the player
	for i in range(10):
		x = randf_range(-9, 9)
		z = randf_range(-9, 9)
		if player == null or Vector3(x, 1, z).distance_to(player.global_position) > 5.0:
			break
	
	enemy.position = Vector3(x, 1, z)
	get_parent().add_child(enemy)
