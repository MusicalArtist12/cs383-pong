extends Control

 

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_settings_pressed() -> void:
	var scene = load("res://settings.tscn")
	var instance = scene.instantiate()
	add_child(instance)


func _on_quit_pressed() -> void:
	get_tree().quit()
