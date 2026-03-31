@tool
extends Node


@export var wwise_event : String:
	set(event):
		if event == "" or not is_inside_tree():
			return
		Wwise.register_game_obj(get_parent(), "x")
		if Wwise.post_event(event, get_parent()) == 0:
			print("Cannot find Wwise event ", event)

func _ready():
	add_to_group("WwiseGameObjects")
