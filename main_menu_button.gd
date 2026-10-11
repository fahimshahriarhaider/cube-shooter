extends Button

func _ready():
	pressed.connect(go_to_menu)

func go_to_menu():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://menu.tscn")
