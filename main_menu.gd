extends Control

func _ready() -> void:
	Settings.winSize = get_viewport_rect().size

func _on_play_pressed() -> void:	
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_settings_pressed() -> void:
	var scene = load("res://settingsMenu.tscn")
	var instance = scene.instantiate()
	add_child(instance)


func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()
