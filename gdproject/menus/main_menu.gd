extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_test_1_pressed() -> void:
	get_tree().change_scene_to_file("res://experimental/test1.tscn")


func _on_test_2_pressed() -> void:
	get_tree().change_scene_to_file("res://experimental/test2.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings_menu.tscn")
