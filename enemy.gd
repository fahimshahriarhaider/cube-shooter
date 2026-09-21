extends CharacterBody3D

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
		
		# If we touch the player, deal 1 damage and disappear
		if global_position.distance_to(player.global_position) < 1.5:
			player.take_damage()
			queue_free()

func die():
	queue_free()
