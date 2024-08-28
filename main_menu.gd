extends Control

func _ready() -> void:
	Settings.winSize = get_viewport_rect().size

func _on_play_pressed() -> void:	
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_settings_pressed() -> void:
	# instantiated so that we can return from it
	var scene = load("res://settingsMenu.tscn")
	var instance = scene.instantiate()
	add_child(instance)

func _on_quit_pressed() -> void:
	get_tree().quit()
