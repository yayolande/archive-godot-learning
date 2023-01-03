extends KinematicBody2D

var motion = Vector2.ZERO
# var speed = 1


func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	# var Player :Node2D = get_tree().get_root().get_node("Player") as Node2D
	var Player :Node2D = get_parent().get_node("Player") as Node2D
	
	var direction : Vector2 = (Player.position - position)
	# direction = direction.normalized()
	position += direction / 50
	look_at(Player.position)
	# motion += direction / 50 * speed
	
	var _kinematic_collision = move_and_collide(motion)
	
	pass


func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
	
	pass # Replace with function body.
