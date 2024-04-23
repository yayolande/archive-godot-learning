extends Node

## Amount of collectables (items) obtained
var points : int = 0

## Max amount of collectable in the level
var max_points : int = 0

signal points_changed (points : int)

func _ready():
	var children : Array[Node] = get_children()
	max_points = children.size()
	
	for child in children:
		assert(child is Area2D, "[Warning] One or more Childreen of " + self.name + " is not of type 'Area2D'")
		
		if not child is Area2D:
			continue
			
		print(child)
		var collectable_item : Area2D = child as Area2D
		(collectable_item).body_entered.connect(_on_body_entered_collectable.bind(collectable_item))
		

func _on_body_entered_collectable(collision_body : Node2D, collectable_item : Area2D):
	print ("Collision Body : " + str(collision_body))
	print ("Collectable Item : " + str(collectable_item))
	
	if collision_body.is_in_group("Player"):
		collectable_item.queue_free()
		points += 1
		#emit_signal("points_changed", points)
		points_changed.emit(points)
		pass
	
	pass
