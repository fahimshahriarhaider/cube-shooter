extends Control

const GAME_SCENE = "res://15.9.26 starting.tscn"
const HIGH_SCORE_FILE = "user://highscore.save"

func _ready():
	$CenterContainer/VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$CenterContainer/VBoxContainer/ExitButton.pressed.connect(_on_exit_pressed)
	load_high_score()

func load_high_score():
	var value = 0
	if FileAccess.file_exists(HIGH_SCORE_FILE):
		var file = FileAccess.open(HIGH_SCORE_FILE, FileAccess.READ)
		if file:
			value = file.get_var()
			file.close()
	var label = $CenterContainer/VBoxContainer/HighScoreLabel
	label.text = "High Score: " + str(value)

func _on_play_pressed():
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_exit_pressed():
	get_tree().quit()
