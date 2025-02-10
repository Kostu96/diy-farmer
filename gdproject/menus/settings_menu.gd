extends Control

func _ready() -> void:
	var vsync : bool = DisplayServer.window_get_vsync_mode() == 1
	$MarginContainer/VBoxContainer/VSyncContainer/VSyncCheckButton.set_pressed_no_signal(vsync)
	var msaa : int = ProjectSettings.get_setting("rendering/anti_aliasing/quality/msaa_3d")
	$MarginContainer/VBoxContainer/MSAAContainer/MSAAOptionButton.select(msaa)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")


func _on_v_sync_check_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED)


func _on_msaa_option_button_item_selected(index: int) -> void:
	ProjectSettings.set_setting("rendering/anti_aliasing/quality/msaa_3d", index)
