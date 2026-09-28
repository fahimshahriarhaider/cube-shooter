extends Button

func _ready():
	pressed.connect(restart_game)

func restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
