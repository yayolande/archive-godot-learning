extends Node

#@export var next_level : PackedScene
@export var next_level_path : StringName

@onready var user_interface = %UI
@onready var ui_points_label : = $"../UI/Panel/Label" as Label
@onready var portal_end_level = %PortalEndLevel



func _ready():
	portal_end_level.body_entered.connect(_on_portal_end_level_body_entered)
	pass

func _on_collectable_manager_points_changed(points):
	print("Yeah, GameManager received the signal from CollectableManager")
	ui_points_label.text = "Points: " + str(points)
	pass # Replace with function body.




func _on_portal_end_level_body_entered(body):
	print("End Level Signal Fired !dda")
	print("body: " + str(body))
	if body.is_in_group("Player"):
		#get_tree().change_scene_to_packed(next_level)
		get_tree().change_scene_to_file(next_level_path)
	pass # Replace with function body.
