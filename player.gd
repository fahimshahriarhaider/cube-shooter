extends CharacterBody3D

@export var speed = 5.0
@export var mouse_sensitivity = 0.002
@export var jump_velocity = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var score = 0
var health = 3

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_to_group("player")
	$Camera3D/RayCast3D.add_exception(self)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -1.5, 1.5)
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			shoot()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func shoot():
	$Camera3D/RayCast3D.force_raycast_update()
	if $Camera3D/RayCast3D.is_colliding():
		var target = $Camera3D/RayCast3D.get_collider()
		print("Hit: ", target.name)
		if target.is_in_group("enemies"):
			target.die()
			score += 1
			var label = get_tree().current_scene.find_child("ScoreLabel", true, false)
			if label:
				label.text = "Score: " + str(score)
	else:
		print("Missed!")

func take_damage():
	health -= 1
	var label = get_tree().current_scene.find_child("HealthLabel", true, false)
	if label:
		label.text = "Health: " + str(health)
	if health <= 0:
		end_game()

func end_game():
	var game_over_label = get_tree().current_scene.find_child("GameOverLabel", true, false)
	if game_over_label:
		game_over_label.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
