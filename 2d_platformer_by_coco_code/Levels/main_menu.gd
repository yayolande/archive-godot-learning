extends Control

@onready var start_game = $Panel/VBoxContainer/HBoxContainer/StartGame
@export var first_level_path : StringName
@export var credit_scene_path : StringName
@export var main_menu_scene_path : StringName

@export var node_to_pause : Array[Node]

func _ready():
	if start_game != null :
		start_game.grab_focus()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_menu") and node_to_pause.size() > 0:
		visible = !visible
		
		for node in node_to_pause:
			get_tree().paused = visible



func _on_quit_game_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_credits_pressed():
	assert(not credit_scene_path.is_empty(), "[Warning] Empty Path")
	
	get_tree().change_scene_to_file(credit_scene_path)
	pass # Replace with function body.


func _on_start_game_pressed():
	assert(not first_level_path.is_empty(), "[Warning] Empty Path")
	
	get_tree().change_scene_to_file(first_level_path)
	pass # Replace with function body.


func _on_continue_pressed():
	get_tree().change_scene_to_file(main_menu_scene_path)
	pass # Replace with function body.


func _on_continue_game_pressed():
	var continue_button_pressed = InputEventAction.new()
	continue_button_pressed.action = "ui_menu"
	continue_button_pressed.pressed = true
	Input.parse_input_event(continue_button_pressed)
	
	pass # Replace with function body.
