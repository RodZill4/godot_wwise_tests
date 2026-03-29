@tool
extends EditorPlugin


func _enable_plugin():
	# Add autoloads here.
	pass


func _disable_plugin():
	# Remove autoloads here.
	pass


func _enter_tree():
	if not Wwise.is_initialized():
		print("Initializing Wwise")
		Wwise.init()
	Wwise.register_game_obj(get_editor_interface().get_editor_viewport_3d().get_camera_3d(), "camera")
	Wwise.add_default_listener(get_editor_interface().get_editor_viewport_3d().get_camera_3d())
	Wwise.load_bank("SFX")

func _exit_tree():
	Wwise.unload_bank("SFX")

func _process(delta):
	Wwise.render_audio()
