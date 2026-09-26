extends CharacterBody3D

const EXPLOSION = preload("res://explosion.tscn")

var speed = 2.0
var player = null

func _ready():
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
		if global_position.distance_to(player.global_position) < 1.5:
			player.take_damage()
			die()

func die():
	var boom = EXPLOSION.instantiate()
	boom.global_position = global_position
	get_parent().add_child(boom)
	queue_free()
