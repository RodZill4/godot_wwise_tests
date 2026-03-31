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
	print(get_path())

func _exit_tree():
	Wwise.unload_bank("SFX")

var game_objects : Array[Node] = []

func add_game_object(o : Node):
	if game_objects.find(o) == -1: 
		Wwise.register_game_obj(o, "Object")
		game_objects.append(o)

func _process(delta):
	var camera : Node3D = get_editor_interface().get_editor_viewport_3d().get_camera_3d()
	Wwise.set_3d_position(camera, camera.global_transform)
	for o in get_tree().get_nodes_in_group("WwiseGameObjects"):
		if o is Node3D:
			Wwise.set_3d_position(o, o.global_transform)
	Wwise.render_audio()
